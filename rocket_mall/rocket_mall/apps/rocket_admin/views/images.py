from rest_framework.viewsets import ModelViewSet
from rest_framework.permissions import IsAdminUser
from rest_framework.response import Response

from goods.models import SKUImage ,SKU
from rocket_admin.utils import PageNum
from rocket_admin.serializers.images import ImageSerializer ,SKUSerializer


class ImageView(ModelViewSet):
    """
    圖片增刪改查操作:ModelViewSet
    """
    permission_classes = [IsAdminUser]
    #指定查詢集
    queryset = SKUImage.objects.all()
    #指定序列化器
    serializer_class = ImageSerializer
    #指定分頁器
    pagination_class = PageNum

    def simple(self, request):
        """
        獲取SKU商品:供後臺運營人員選擇商品使用
        :param request:
        :return:
        """
        skus = SKU.objects.all()
        ser = SKUSerializer(skus, many=True)
        return Response(ser.data)