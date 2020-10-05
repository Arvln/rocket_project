from rest_framework import serializers
from django.db import transaction

from goods.models import SKU ,SKUSpecification ,GoodsCategory ,Goods ,GoodsSpecification ,SpecificationOption


class SpecOptionSerializer(serializers.ModelSerializer):
    """SPU規格選項序列化器"""
    class Meta:
        model = SpecificationOption
        fields = ('id','value')

class GoodsSpecSerializer(serializers.ModelSerializer):
    """SPU規格序列化器"""
    #嵌套序列化返回:PrimaryKeyRelatedField/StringRelatedField/Nested relationships
    goods = serializers.StringRelatedField(read_only=True)
    goods_id = serializers.IntegerField()
    specificationoption_set = SpecOptionSerializer(many=True)
    class Meta:
        model = GoodsSpecification
        fields = '__all__'

class SKUSpecSerializer(serializers.ModelSerializer):
    """SKU規格序列化器"""
    spec_id = serializers.IntegerField()
    option_id = serializers.IntegerField()
    class Meta:
        model = SKUSpecification
        fields = ('spec_id','option_id')

class SKUSerializer(serializers.ModelSerializer):
    """SKU序列化器"""
    goods_id = serializers.IntegerField()
    category_id = serializers.IntegerField()
    skuspecification_set = SKUSpecSerializer(read_only=True, many=True) #嵌套序列化返回
    class Meta:
        model = SKU
        fields = '__all__'
        read_only_fields = ('goods','category') #前端請求體中不須傳送的待序列化字段

    def create(self, validated_data):
        """新增SKU商品數據"""
        #獲取SKU規格資訊
        specs = self.context['request'].data.get('skuspecification_set')
        #開啟事務
        with transaction.atomic():
            #建立事務保存點
            save_point = transaction.savepoint()
            try:
                #新增SKU商品數據
                sku = SKU.objects.create(**validated_data)
                #逐項新增SKU商品規格數據
                for spec in specs:
                    SKUSpecification.objects.create(sku=sku, **spec)
            except:
                #回滾
                transaction.savepoint_rollback(save_point)
                raise serializers.ValidationError('商品保存失敗')
            #提交
            transaction.savepoint_commit(save_point)
            return sku

    def update(self, instance, validated_data):
        """更新SKU商品數據"""
        #獲取SKU規格資訊
        specs = self.context['request'].data.get('skuspecification_set')
        #開啟事務
        with transaction.atomic():
            #建立事務保存點
            save_point = transaction.savepoint()
            try:
                #更新SKU商品數據
                SKU.objects.filter(id=instance.id).update(**validated_data)
                #更新SKU商品規格數據
                SKUSpecification.objects.filter(sku=instance).delete()
                for spec in specs:
                    SKUSpecification.objects.create(sku=instance, **spec)
            except:
                #回滾
                transaction.savepoint_rollback(save_point)
                raise serializers.ValidationError('商品保存失敗')
            #提交
            transaction.savepoint_commit(save_point)
            return instance

class GoodsCategorySerializer(serializers.ModelSerializer):
    """三級分類序列化器"""
    class Meta:
        model = GoodsCategory
        fields = ('id','name')