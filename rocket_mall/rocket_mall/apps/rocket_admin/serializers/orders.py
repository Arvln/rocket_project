from rest_framework import serializers

from orders.models import OrderInfo ,OrderGoods ,SKU


class SKUSerializer(serializers.ModelSerializer):
    """SKU序列化器"""
    class Meta:
        model = SKU
        fields = ('name','default_image_url')

class OrderGoodsSerializer(serializers.ModelSerializer):
    """訂單商品序列化器"""
    sku = SKUSerializer()
    class Meta:
        model = OrderGoods
        fields = ('count','price','sku')

class OrderInfoSerializer(serializers.ModelSerializer):
    """訂單序列化器"""
    skus = OrderGoodsSerializer(many=True)
    class Meta:
        model = OrderInfo
        fields = '__all__'