from rest_framework import serializers

from goods.models import GoodsSpecification ,Goods


class GoodsSpecSerializer(serializers.ModelSerializer):
    """
    商品規格序列化器:類序列化器用ModelSerializer
    """
    #嵌套序列化返回:PrimaryKeyRelatedField/StringRelatedField/Nested relationships
    """
    {
        "id": "規格id",
        "name": "規格名稱",
        "Goods": "SPU商品名稱",
        "Goods_id": "SPU商品id"
    }
    """
    goods = serializers.StringRelatedField(read_only=True)
    goods_id = serializers.IntegerField()
    class Meta:
        model = GoodsSpecification
        fields = '__all__'

class GoodsSerializer(serializers.ModelSerializer):
    """SPU序列化器"""
    class Meta:
        model = Goods
        fields = ('id','name')