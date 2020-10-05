from rest_framework.decorators import action
from rest_framework.viewsets import ModelViewSet
from rest_framework.permissions import IsAdminUser
from rest_framework.response import Response

from goods.models import GoodsSpecification ,Goods
from rocket_admin.serializers.specs import GoodsSpecSerializer ,GoodsSerializer
from rocket_admin.utils import PageNum

#需求:商品規格表增刪改查操作
class SpecView(ModelViewSet):
    """
    商品規格表管理
    使用可實現CRUD的擴展類:ModelViewSet
    """
    #指定視圖訪問權限
    permission_classes = [IsAdminUser]
    #指定查詢集
    queryset = GoodsSpecification.objects.all()
    #指定序列化器
    serializer_class = GoodsSpecSerializer
    #指定分頁器
    pagination_class = PageNum

    def simple(self, request):
        """
        獲取SPU商品:供後臺運營人員選擇商品使用
        :param request: request
        :return:
        """
        goods = Goods.objects.all()
        ser = GoodsSerializer(goods, many=True)
        return Response(ser.data)