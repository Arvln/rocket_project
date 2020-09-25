from decimal import Decimal

from django_redis import get_redis_connection
from goods.models import SKU


def get_orders_from_redis(request ,user):
    """查詢訂單商品數據"""
    #查詢購物車中被勾選的商品
    redis_conn = get_redis_connection('cart')

    selected_sku_ids = redis_conn.smembers('selected_%s' % user.id)
    selected_sku_counts = redis_conn.hmget('carts_%s' % user.id, *selected_sku_ids)
    skus = []
    #提取商品數據
    total_count = 0
    total_amount = Decimal(0.00)  # 總金額取到小數第二位
    for index, sku_id in enumerate(selected_sku_ids):
        sku = SKU.objects.get(id=int(sku_id))
        count = int(selected_sku_counts[index])
        sku_dict = {
            'id': sku.id,
            'name': sku.name,
            'price': sku.price,
            'count': count,
            'amount': sku.price * count,
            'default_image_url': sku.default_image_url,
        }
        #識別用戶獲取或提交訂單，提交訂單須等MySQL操作完商品銷量和庫存再計算商品總數/總金額
        if request.method == 'GET':
            total_count += count
            total_amount += sku.price * count
        skus.append(sku_dict)

    return skus ,total_count ,total_amount