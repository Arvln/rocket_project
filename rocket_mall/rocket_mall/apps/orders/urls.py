from django.conf.urls import url
from . import views

urlpatterns = [
    #返回訂單結算頁面的後端接口
    url(r'^api/orders/info/$' ,views.OrderInfoView.as_view() ,name='info' ),
    #查詢訂單結算數據的後端接口
    url(r'^api/orders/settlement/$' ,views.OrderSettlementView.as_view() ),
    #提交訂單的後端接口
    url(r'^api/orders/submission/$' ,views.OrderSubmitView.as_view() ),
    #提交訂單成功頁面或查詢訂單數據的後端接口
    url(r'^api/orders/seccess/$', views.OrderSeccessView.as_view() ),
]