from rest_framework import serializers

from goods.models import GoodsVisitCount


class CategoriesDailyVisitSerializer(serializers.ModelSerializer):
    #嵌套序列化指定返回字段
    category = serializers.PrimaryKeyRelatedField(read_only=True)
    class Meta:
        model = GoodsVisitCount
        fields = ('category','count')