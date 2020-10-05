from rest_framework import serializers
from rest_framework.response import Response

from goods.models import SKUImage ,SKU
from fdfs_client.client import Fdfs_client
from settings import dev


class ImageSerializer(serializers.ModelSerializer):
    """圖片序列化器"""
    sku_id = serializers.IntegerField()
    class Meta:
        model = SKUImage
        fields = '__all__'
    #重寫序列化器create和update方法支持新增、更新圖片功能
    def create(self, validated_data):
        """新增圖片"""
        #建立Fastdfs客戶端
        client = Fdfs_client(dev.FASTDFS_PATH)
        file = self.context['request'].Files.get('image')
        #上傳圖片
        res = client.upload_by_file(file.read())
        #判斷是否上傳成功
        if res['Status'] != 'Upload successed.':
            return Response({'error':'圖片上傳失敗'})
        #保存圖片
        img = SKUImage.objects.create(image=res['Remote file_id'], **validated_data)
        return img

    def update(self, instance, validated_data):
        """更新圖片"""
        #建立Fastdfs客戶端
        client = Fdfs_client(dev.FASTDFS_PATH)
        file = self.context['request'].Files.get('image')
        #上傳圖片
        res = client.upload_by_file(file.read())
        #判斷是否上傳成功
        if res['Status'] != 'Upload successed.':
            return Response({'error': '圖片上傳失敗'})
        #更新圖片
        SKUImage.objects.filter(sku=instance).update(img=res['Remote file_id'])
        return instance

class SKUSerializer(serializers.ModelSerializer):
    """SKU序列化器"""
    class Meta:
        model = SKU
        fields = ('id','name')