import pickle ,base64 ,json
from django.http import HttpResponseForbidden

from goods.models import SKU

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