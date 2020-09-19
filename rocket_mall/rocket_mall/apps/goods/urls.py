from django.conf.urls import url
from . import views

urlpatterns = [
    #查詢商品列表頁的後端接口
    url(r'^api/list/(?P<category_id>\d+)/(?P<page_num>\d+)/$' ,views.ListView.as_view() ,name='list' ),
    #查詢暢銷商品的後端接口
    url(r'^api/hot_good/get/(?P<category_id>\d+)/$' ,views.HotGoodsView.as_view() )
]