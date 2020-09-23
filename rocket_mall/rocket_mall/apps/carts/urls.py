from django.conf.urls import url
from . import views

urlpatterns = [
    #獲取、新增、修改、刪除購物車資訊的後端接口
    url(r'^api/carts/$' ,views.CartsView.as_view() ,name='info'),
    #購物車全選的後端接口
    url(r'^api/carts/selection/$' ,views.CartsSelectAllView.as_view() ),
]