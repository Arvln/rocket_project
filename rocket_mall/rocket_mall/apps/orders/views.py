from django.shortcuts import render
from django.views import View
from utils.views import LoginRequiredMixin ,LoginRequiredJsonMixin
from django.http import JsonResponse ,HttpResponseForbidden
import json ,logging
from django.utils import timezone
from django.db import transaction

from users.models import Address
from areas.models import Area
from . import constants ,utils
from utils.response_code import RETCODE
from orders.models import OrderInfo ,OrderGoods
from goods.models import SKU

# Create your views here.

logger = logging.getLogger('django')

class OrderSettlementView(LoginRequiredMixin ,View):
    """結算訂單"""
    def get(self ,request ):
        """查詢訂單結算頁面數據"""

        #查詢用戶
        user=request.user
        #查詢用戶收貨地址:登錄用戶未被刪除的地址
        try:
            address_model_list = Address.objects.filter(user=user ,is_deleted=False )
        except:
            #沒有查詢地址可以編輯收貨地址
            addresses = None
        else:
            addresses = []
            for address in address_model_list:
                address_dict = {
                    'id':address.id ,
                    'area': Area.objects.get(id=address.area_id).name ,
                    'city': Area.objects.get(id=address.city_id).name ,
                    'district': Area.objects.get(id=address.district_id).name ,
                    'place': address.place ,
                }
                addresses.append(address_dict)

        #從redis中提取購物車中勾選的商品資訊
        skus, total_count, total_amount = utils.get_orders_from_redis(request ,user )

        #構造響應數據
        orders = {
            'addresses':addresses ,
            'default_address_id':user.default_address_id ,
            'mobile': '(+886)' + user.mobile[1:] ,
            'skus':skus ,
            'total_count':total_count ,
            'total_amount':total_amount ,
            'freight':constants.FREIGHT_PER_ORDER ,
            'total_payment':total_amount + constants.FREIGHT_PER_ORDER ,
        }
        return JsonResponse({'code':RETCODE.OK ,'errmsg':'OK' ,'orders':orders })


class OrderInfoView(LoginRequiredMixin ,View):
    """返回訂單結算頁面"""
    def get(self ,request ):

        return render(request ,'place_order.html' )

class OrderSubmitView(LoginRequiredJsonMixin ,View):
    """提交訂單的後端接口"""
    def post(self ,request ):

        #接收參數
        json_dict = json.loads(request.body.decode())
        address_id = json_dict.get('address_id')
        pay_method = json_dict.get('pay_method')
        #校驗參數
        if not all([address_id ,pay_method ]):
            return HttpResponseForbidden('缺少必傳參數')
        try:
            address = Address.objects.get(id=address_id)
        except Exception:
            return HttpResponseForbidden('請確認用戶收貨地址是否正確')
        if pay_method not in ([OrderInfo.PAY_METHODS_ENUM['CASH'] ,OrderInfo.PAY_METHODS_ENUM['ALIPAY'] ,OrderInfo.PAY_METHODS_ENUM['LINEPAY'] ]):
            return HttpResponseForbidden('請確認支付方式是否正確')

        #明顯地開啟一次事務:同時操作四張表，需要確保資料庫數據的一致性
        with transaction.atomic():
            #建立事務的保存點
            save_id = transaction.savepoint()
            #遇MySQL操作異常一律暴力回滾
            try:
                #獲取訂單的編號:時間+用戶ID
                user = request.user
                order_id = timezone.localtime().strftime('%Y%m%d%H%M%S') + ('%09d' % user.id)
                # 從redis提取用戶購買商品資訊
                skus ,total_count ,total_amount = utils.get_orders_from_redis(request ,user )
                #保存訂單基本資料
                order = OrderInfo.objects.create(
                    order_id = order_id ,
                    user = user ,
                    address = address ,
                    total_count = total_count ,
                    total_amount = total_amount ,
                    freight = constants.FREIGHT_PER_ORDER ,
                    pay_method = pay_method ,
                    status = OrderInfo.ORDER_STATUS_ENUM['UNSEND'] if pay_method == OrderInfo.PAY_METHODS_ENUM['CASH'] else OrderInfo.ORDER_STATUS_ENUM['UNPAID'] ,
                )
                #保存商品基本資料
                for orders_sku in skus:
                    sku_id = orders_sku['id']
                    count = orders_sku['count']
                    #每個商品都有多次下單的機會，直到庫存不足
                    while True:
                        #判斷商品數量是否大於庫存
                        #查詢商品庫存時，不能用filter查詢(緩存數據)，需要查詢最新庫存數據
                        sku = SKU.objects.get(id=sku_id)

                        #獲取原始的商品庫存和銷量
                        origin_stock = sku.stock
                        origin_sales = sku.sales

                        if count > origin_stock:
                            transaction.savepoint_rollback(save_id)  # 回滾事務
                            return JsonResponse({'code':RETCODE.STOCKERR ,'errmsg':'庫存不足'})
                        #商品銷量與庫存同步到MySQL
                        #SKU表中減庫存、加銷量:關鍵操作加上樂觀鎖，避免資源搶奪
                        new_stock = origin_stock - count
                        new_sales = origin_sales + count
                        result = SKU.objects.filter(id=sku_id ,stock=origin_stock ).update(stock=new_stock ,sales=new_sales )

                        #發生資源搶奪，重新再下單
                        if result == 0:
                            continue

                        #GOODS表中加銷量
                        sku.goods.sales += count
                        sku.goods.save()
                        #計算商品總數和總金額
                        order.total_count += count
                        order.total_amount += sku.price*count #商品總金額

                        OrderGoods.objects.create(
                            order = order ,
                            sku = sku ,
                            count = count ,
                            price = sku.price ,
                        )

                        #下單成功，跳出重新下單迴圈，繼續購買下個商品
                        break
                #總付款金額(含運)
                order.total_amount += order.freight
                order.save()
            except Exception as e:
                logger.error(e)
                transaction.savepoint_rollback(save_id)
                return JsonResponse({'code': RETCODE.DBERR, 'errmsg': '提交訂單失敗'})

            #明顯地提交一次事務
            transaction.savepoint_commit(save_id)

        return JsonResponse({'code':RETCODE.OK ,'errmsg':'OK' })

class OrderSeccessView(LoginRequiredMixin ,View):
    """提交訂單成功頁面"""
    def get(self ,request ):
        """提供提交訂單成功頁面或訂單數據"""

        #獲取登錄用戶
        user = request.user
        #構造響應數據
        order = OrderInfo.objects.get(user=user)
        orders = {}
        orders['order_id'] = order.order_id
        orders['payment_amount'] = order.total_amount
        orders['pay_method'] = order.pay_method

        if request.GET.get('orders') is not None:
            return JsonResponse({'code':RETCODE.OK ,'errmsg':'OK' ,'orders':orders })

        return render(request ,'order_seccess.html' )