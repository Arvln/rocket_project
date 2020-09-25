from django.conf.urls import url
from . import views

urlpatterns = [
    #訂單支付的後端接口
    url(r'^api/payment/(?P<order_id>\d+)/$' ,views.PaymentView.as_view() ),
    #保存支付訂單狀態的後端接口
    url(r'^api/payment/status/$' ,views.PaymentStatusView.as_view() ),
]