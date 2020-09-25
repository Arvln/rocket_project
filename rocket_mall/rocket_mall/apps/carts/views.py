from django.shortcuts import render
from django.views import View
from django.http import HttpResponseForbidden ,JsonResponse
from django_redis import get_redis_connection
from django.middleware.csrf import get_token
import json

from goods.models import SKU
from users.models import User
from utils.response_code import RETCODE
from carts.utils import get_cookie_cart_dict ,get_cookie_cart_str ,check_params

# Create your views here.

class CartsSelectAllView(View):
    """購物車全選"""
    def put(self ,request ):

        #接收參數
        selected = json.loads(request.body.decode()).get('selected', True)
        #校驗參數
        if not isinstance(selected, bool):
            return HttpResponseForbidden('selected有誤')

        #判斷用戶是否登錄
        try:
            user = User.objects.get(id=request.user.id)
        except:
            #用戶未登錄操作cookies
            cart_str = request.COOKIES.get('carts')
            response = JsonResponse({'code': RETCODE.OK, 'errmsg': 'OK'})
            if cart_str:
                cart_dict = get_cookie_cart_dict(cart_str)
                for sku in cart_dict.values():
                    sku['selected'] = selected
                cart_str = get_cookie_cart_str(cart_dict)
                response.set_cookie('carts', cart_str)
            return response
        else:
            #用戶已登入操作redis
            redis_conn = get_redis_connection('cart')
            redis_dict = redis_conn.hgetall('carts_%s' %user.id)
            sku_ids = redis_dict.keys()
            pl = redis_conn.pipeline()
            if selected:
                #全選
                pl.sadd('selected_%s' % user.id, *sku_ids)
            else:
                #取消全選
                pl.srem('selected_%s' %user.id ,*sku_ids )
            pl.execute()
            return JsonResponse({'code':RETCODE.OK ,'errmsg':'OK' })

class CartsView(View):
    """獲取購物車資訊"""
    def get(self ,request ):
        """獲取購物車"""
        #判斷用戶是否登錄
        try:
            user = User.objects.get(id=request.user.id)
        except:
            #用戶未登錄操作cookies
            cart_str = request.COOKIES.get('carts')
            if cart_str:
                cart_dict = get_cookie_cart_dict(cart_str)
            else:
                cart_dict = {}
            #用戶不須登入，所以設置csrftoken，以利後續的增刪改操作
            get_token(request)
        else:
            #用戶已登入操作redis
            redis_conn = get_redis_connection('cart')
            #查詢hash數據:Field(sku_id)/Value(count)
            redis_dict = redis_conn.hgetall('carts_%s' %user.id )
            #查詢set數據:已勾選的商品sku_id
            redis_set = redis_conn.smembers('selected_%s' %user.id )
            #按照未登錄用戶的cookie字典資料結構重構數據，方便後續統一處理
            cart_dict = {}
            for sku_id ,count in redis_dict.items():
                #redis返回bytes類型轉int類型
                cart_dict[int(sku_id)] = {
                    'count':int(count) ,
                    'selected':sku_id in redis_set , #判斷用戶是否勾選返回bool
                }
        #構造響應數據
        cart_skus = []
        for sku_id, sku_info in cart_dict.items():
            sku = SKU.objects.get(id=sku_id)
            count = sku_info['count']
            cart_skus.append({
                'id': sku.id,
                'name': sku.name,
                'count': count,
                'selected': str(sku_info['selected']),
                'default_image_url': sku.default_image_url,
                'price': str(sku.price),
                'amount': str(sku.price * count),
            })
        context = {
            'cart_skus':cart_skus ,
        }
        #判斷請求頁面的響應方式
        request_from = request.GET.get('carts')
        if request_from:
            return JsonResponse({'code':RETCODE.OK ,'errmsg':'OK' ,'cart_skus':cart_skus })

        return render(request ,'cart.html' ,context )

    def post(self ,request ):
        """新增購物車數據"""
        #接收並校驗參數
        sku_id ,count ,selected ,sku = check_params(request)
        #判斷用戶是否登錄
        try:
            user = User.objects.get(id=request.user.id)
        except:
            #用戶未登錄操作cookies
            cart_str = request.COOKIES.get('carts')
            if cart_str:
                cart_dict = get_cookie_cart_dict(cart_str)
            else:
                cart_dict = {}
            #商品原購買數量
            if sku_id in cart_dict:
                origin_count = cart_dict[sku_id]['count']
            else:
                origin_count = 0
            #需求:單品購買量最多5件且小於當前商品庫存量，否則購物車數據不變
            count += origin_count
            if count > 5:
                count = origin_count
                response = JsonResponse({'code':RETCODE.SESSIONERR ,'errmsg':'商品已達購買上限'})
            elif count > sku.stock:
                count = origin_count
                response = JsonResponse({'code':RETCODE.SESSIONERR ,'errmsg':'商品庫存不足'})
            else:
                response = JsonResponse({'code': RETCODE.OK, 'errmsg': 'OK'})

            cart_dict[sku_id] = {
                'count': count,
                'selected': selected,
            }
            cart_str = get_cookie_cart_str(cart_dict)
            response.set_cookie('carts', cart_str)
            return response
        else:
            #用戶已登入操作redis
            redis_conn = get_redis_connection('cart')
            #商品原購買數量
            try:
                origin_count = int(redis_conn.hget('carts_%s' %user.id ,sku_id ))
            except:
                origin_count = 0
            #需求:單品購買量最多5件且小於當前商品庫存量，否則購物車數據不變
            if origin_count+count > 5:
                return JsonResponse({'code':RETCODE.SESSIONERR ,'errmsg':'商品已達購買上限'})
            elif origin_count+count > sku.stock:
                return JsonResponse({'code':RETCODE.STOCKERR ,'errmsg':'商品庫存不足'})
            else:
                pl = redis_conn.pipeline()
                #增量計算保存商品購買量
                pl.hincrby('carts_%s' %user.id ,sku_id ,count )
                pl.hget('carts_%s' %user.id ,sku_id )
                if selected:
                    pl.sadd('selected_%s' %user.id ,sku_id )
                pl.execute()
                return JsonResponse({'code':RETCODE.OK ,'errmsg':'OK' })

    def put(self ,request ):
        """修改購物車數據"""
        #接收並校驗參數
        sku_id, count, selected ,sku = check_params(request)
        #判斷用戶是否登錄
        try:
            user = User.objects.get(id=request.user.id)
        except:
            #用戶未登錄操作cookies
            cart_str = request.COOKIES.get('carts')
            if cart_str:
                cart_dict = get_cookie_cart_dict(cart_str)
            else:
                cart_dict = {}
            #商品原購買數量
            if sku_id in cart_dict:
                origin_count = cart_dict[sku_id]['count']
            else:
                origin_count = 0
            #構造響應數據
            sku = SKU.objects.get(id=sku_id)
            cart_sku = {
                'id': sku.id,
                'name': sku.name,
                'count': count,
                'selected': selected,
                'default_image_url': sku.default_image_url,
                'price': sku.price,
                'amount': sku.price * count,
            }
            #需求:單品購買量最多5件且小於當前商品庫存量，否則購物車數據不變
            if count > 5:
                count = origin_count
                cart_sku['count'] = count
                response = JsonResponse({'code':RETCODE.SESSIONERR ,'errmsg':'商品已達購買上限', 'cart_sku': cart_sku})
            elif count > sku.stock:
                count = origin_count
                cart_sku['count'] = count
                response = JsonResponse({'code':RETCODE.STOCKERR ,'errmsg':'商品庫存不足', 'cart_sku': cart_sku})
            else:
                response = JsonResponse({'code': RETCODE.OK, 'errmsg': 'OK', 'cart_sku': cart_sku})
            #前端傳來數據覆蓋寫入
            cart_dict[sku_id]['count'] = count
            cart_dict[sku_id]['selected'] = selected
            cart_str = get_cookie_cart_str(cart_dict)
            response.set_cookie('carts' ,cart_str )
            return response
        else:
            #用戶已登入操作redis
            redis_conn = get_redis_connection('cart')
            # 商品原購買數量
            try:
                origin_count = int(redis_conn.hget('carts_%s' % user.id, sku_id))
            except:
                origin_count = 0
            #構造響應數據
            sku = SKU.objects.get(id=sku_id)
            cart_sku = {
                'id': sku.id,
                'name': sku.name,
                'count': count,
                'selected': selected,
                'default_image_url': sku.default_image_url,
                'price': sku.price,
                'amount': sku.price * count,
            }
            #需求:單品購買量最多5件且小於當前商品庫存量，否則購物車數據不變
            if count > 5:
                cart_sku['count'] = origin_count
                return JsonResponse({'code': RETCODE.SESSIONERR, 'errmsg': '商品已達購買上限' ,'cart_sku':cart_sku })
            elif count > sku.stock:
                cart_sku['count'] = origin_count
                return JsonResponse({'code': RETCODE.STOCKERR, 'errmsg': '商品庫存不足' ,'cart_sku':cart_sku })
            else:
                #前端傳來數據覆蓋寫入
                pl = redis_conn.pipeline()
                pl.hset('carts_%s' %user.id ,sku_id ,count )
                if selected:
                    pl.sadd('selected_%s' %user.id ,sku_id )
                else:
                    pl.srem('selected_%s' %user.id ,sku_id )
                pl.execute()

                return JsonResponse({'code':RETCODE.OK ,'errmsg':'OK' ,'cart_sku':cart_sku })

    def delete(self,request ):
        """删除購物車數據"""
        #提取參數
        sku_id = json.loads(request.body.decode()).get('sku_id')
        #校驗參數
        try:
            SKU.objects.get(id=sku_id)
        except Exception:
            return HttpResponseForbidden('該商品不存在')
        #刪除商品
        try:
            user = User.objects.get(id=request.user.id)
        except Exception:
            #用戶未登錄操作cookies
            cart_str = request.COOKIES.get('carts')
            #購物車數據不存在直接響應
            response = JsonResponse({'code': RETCODE.OK, 'errmsg': 'OK'})
            if cart_str:
                cart_dict = get_cookie_cart_dict(cart_str)
                cart_dict.pop(sku_id ,None )
                cart_str = get_cookie_cart_str(cart_dict)
                response.set_cookie('carts' ,cart_str )
            return response
        else:
            #用戶已登入操作redis
            redis_conn = get_redis_connection('cart')
            pl = redis_conn.pipeline()
            #同步刪除商品和勾選狀態
            pl.hdel('carts_%s' %user.id ,sku_id )
            pl.srem('selected_%s' %user.id ,sku_id )
            pl.execute()
            return JsonResponse({'code':RETCODE.OK ,'errmsg':'OK' })
