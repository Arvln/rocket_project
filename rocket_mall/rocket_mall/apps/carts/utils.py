import pickle ,base64 ,json
from django.http import HttpResponseForbidden

from goods.models import SKU
from django_redis import get_redis_connection

def get_cookie_cart_dict(cookie_cart_str):
    """反序列化cookie數據"""
    #校驗前端傳來的cookies數據
    try:
        #將cart_str轉成bytes類型字符串
        cart_str_bytes = cookie_cart_str.encode()
        #將bytes類型字符串轉bytes類型字典
        cookie_dict_bytes = base64.b64decode(cart_str_bytes)
        #將bytes類型字典轉cookie_cart_dict
        cookie_cart_dict = pickle.loads(cookie_dict_bytes)
    except Exception:
        return HttpResponseForbidden('cookies數據錯誤')
    return cookie_cart_dict

def get_cookie_cart_str(cookie_cart_dict):
    """序列化cookie數據"""
    #將cookie_cart_dict轉bytes類型字典
    cart_dict_bytes = pickle.dumps(cookie_cart_dict)
    #將bytes類型字典轉bytes類型字符串
    cart_str_bytes = base64.b64encode(cart_dict_bytes)
    #將bytes類型字符串轉cookie_cart_str
    cookie_cart_str = cart_str_bytes.decode()
    return cookie_cart_str

def check_params(request):
    """接收並校驗購物車數據"""
    #接收參數
    json_dict = json.loads(request.body.decode())
    sku_id = json_dict.get('sku_id')
    count = json_dict.get('count')
    selected = json_dict.get('selected', True)
    #校驗參數
    if not all([sku_id, count]):
        return HttpResponseForbidden('缺少必傳參數')
    try:
        SKU.objects.get(id=sku_id)
    except Exception:
        return HttpResponseForbidden('該商品不存在')
    try:
        count = int(count)
    except Exception:
        return HttpResponseForbidden('count有誤')
    if not isinstance(selected, bool):
        return HttpResponseForbidden('selected有誤')

    return sku_id ,count ,selected

def merge_carts_cookies_redis(request ,user ,response ):
    """合併cookies和redis中的購物車數據"""
    #需求:用戶登錄成功後，將cookies購物車數據覆蓋寫入redis
    #提取cookies購物車數據
    cart_str = request.COOKIES.get('carts')
    #判斷cookies是否存在
    if cart_str:
        cart_dict = get_cookie_cart_dict(cart_str)
        #構造數據
        sku_dict = {}
        selected_list = []
        unselected_list = []
        for sku_id ,sku_info in cart_dict.items():
            sku_dict[sku_id] = sku_info['count']
            if sku_info['selected']:
                selected_list.append(sku_id)
            else:
                unselected_list.append(sku_id)
        #寫入redis
        redis_conn = get_redis_connection('cart')
        pl = redis_conn.pipeline()
        pl.hmset('carts_%s' %user.id ,sku_dict ) #hmset / mapping dict
        if selected_list:
            pl.sadd('selected_%s' %user.id ,*selected_list )
        if unselected_list:
            pl.srem('selected_%s' %user.id ,*unselected_list )
        pl.execute()
        #刪除cookies購物車數據
        response.delete_cookie('carts')

    return response