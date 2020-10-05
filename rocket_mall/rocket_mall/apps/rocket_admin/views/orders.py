from rest_framework.viewsets import ReadOnlyModelViewSet
from rest_framework.permissions import IsAdminUser
from rest_framework.response import Response
from rest_framework.decorators import action

from rocket_admin.utils import PageNum
from orders.models import OrderInfo
from rocket_admin.serializers.orders import OrderInfoSerializer


class OrderView(ReadOnlyModelViewSet):
    """
    訂單表增刪改
    使用只能查詢、新增的擴展類:ReadOnlyModelViewSet
    """
    permission_classes = [IsAdminUser]
    #指定查詢集
    queryset = OrderInfo.objects.all()
    #指定序列化器
    serializer_class = OrderInfoSerializer
    #指定分頁器
    pagination_class = PageNum

    #重寫指定查詢集數據的方法
    def get_queryset(self):
        if self.request.query_params.get('keyword') in ['', None]:
            return OrderInfo.objects.all()
        else:
            #模糊查詢
            return OrderInfo.objects.filter(order_id__contains=self.request.query_params.get('keyword'))

    @action(methods=['put'], detail=True)
    def status(self, request, pk):
        """修改訂單狀態"""
        #校驗訂單編號
        try:
            order = OrderInfo.objects.get(order_id=pk)
        except:
            return Response({'error':'訂單編號錯誤'})
        #校驗訂單狀態訊息
        status = request.data.get('status')
        try:
            status = int(status)
        except:
            return Response({'error':'訂單資訊不正確'})
        #修改訂單狀態
        order.status = status
        order.save()
        return Response({
            'order_id':order.order_id ,
            'status':status ,
        })