from rest_framework.viewsets import ModelViewSet
from rest_framework.permissions import IsAdminUser
from rest_framework.response import Response
from rest_framework.decorators import action

from goods.models import SKU ,GoodsCategory ,GoodsSpecification
from rocket_admin.serializers.skus import SKUSerializer ,GoodsCategorySerializer ,GoodsSpecSerializer
from rocket_admin.utils import PageNum


class SKUView(ModelViewSet):
    """
    SKU表管理
    使用可實現CRUD的擴展類:ModelViewSet
    """
    permission_classes = [IsAdminUser]
    #指定查詢集
    queryset = SKU.objects.all()
    #指定序列化器
    serializer_class = SKUSerializer
    #指定分頁器
    pagination_class = PageNum
    #重寫指定查詢集數據的方法
    def get_queryset(self):
        if self.request.query_params.get('keyword') in ['', None]:
            return SKU.objects.all()
        else:
            #模糊查詢
            return SKU.objects.filter(name__contains=self.request.query_params.get('keyword'))

    @action(methods=['get'], detail=False) #不須生成正則匹配:detail=False
    def categories(self, request):
        """
        獲取三級分類資訊:供後臺運營人員選擇商品分類使用
        """
        categories = GoodsCategory.objects.filter(subs__id=None)
        ser = GoodsCategorySerializer(categories, many=True)
        return Response(ser.data)

    def specs(self, request, pk):
        """
        獲取SPU商品規格資訊:供後臺運營人員選擇商品規格使用
        """
        specs = GoodsSpecification.objects.filter(id=pk)
        ser = GoodsSpecSerializer(specs, many=True)
        return Response(ser.data)