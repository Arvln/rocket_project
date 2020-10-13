from django.shortcuts import render
from django.views import View
from django.http import JsonResponse ,HttpResponseForbidden

from utils.views import LoginRequiredJsonMixin
from alipay import AliPay
from alipay.utils import AliPayConfig
import settings
from orders.models import OrderInfo
from utils.response_code import RETCODE
from payment.keys.app_private_key import app_private_key_string
from payment.keys.alipay_public_key import alipay_public_key_string
from payment.models import Payment

# Create your views here.


#創建對接支付寶的SDK對象
alipay = AliPay(
            appid=settings.ALIPAY_APPID ,
            #默認回調URL:異步通知
            app_notify_url=None ,
            #商城加密私鑰
            app_private_key_string=app_private_key_string ,
            alipay_public_key_string=alipay_public_key_string ,
            #解密支付寶數據的支付寶公鑰
            sign_type="RSA2" ,
            debug = settings.ALIPAY_DEBUG ,
            #請求超時時間
            config = AliPayConfig(timeout=15) ,
        )

class PaymentStatusView(LoginRequiredJsonMixin ,View):
    """保存支付訂單狀態"""
    def get(self ,request ):

        #獲取所有查詢字符串參數
        query_dict = request.GET
        #將查詢字符串參數轉字典類型
        data = query_dict.dict()
        #移除參數sign後簽名數據
        signature = data.pop('sign')
        #使用SDK對象調用驗證接口函數進行驗證
        success = alipay.verify(data ,signature )
        #通過驗證後對支付狀態做處理
        if success:
            order_id = data['out_trade_no']
            trade_id = data['trade_no']
            #更新支付狀態
            OrderInfo.objects.filter(order_id=order_id ,status=OrderInfo.ORDER_STATUS_ENUM['UNPAID'] ).update(status=OrderInfo.ORDER_STATUS_ENUM['UNCOMMENT'])
            #將訂單ID和支付寶的訂單ID綁定在一起
            Payment.objects.create(order_id=order_id ,trade_id=trade_id)
            return render(request ,'pay_success.html' ,{'trade_id':trade_id})
        else:
            return HttpResponseForbidden('非法請求')

class PaymentView(LoginRequiredJsonMixin ,View):
    """對接支付寶的支付接口"""
    def get(self ,request ,order_id ):

        #校驗order_id
        try:
            order = OrderInfo.objects.get(order_id=order_id ,user=request.user ,pay_method=OrderInfo.PAY_METHODS_ENUM['ALIPAY'] )
        except Exception:
            return HttpResponseForbidden('請確認訂單內容是否正確')

        #SDK對象對接支付寶的支付接口，獲取登錄頁地址
        order_string = alipay.api_alipay_trade_page_pay(
            out_trade_no=order_id ,
            total_amount=str(order.total_amount) ,
            subject='RockeT%s' % order_id ,
            return_url=settings.ALIPAY_RETURN_URL ,
        )
        #拼接支付寶登錄頁URL
        alipay_url = settings.ALIPAY_URL + '?' + order_string
        return JsonResponse({'code':RETCODE.OK ,'errmsg':'OK' ,'alipay_url':alipay_url })