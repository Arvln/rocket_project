from django.conf.urls import url
from . import views

urlpatterns = [
    #獲取用戶所在地區後端接口
    url(r'^api/areas/get/$' ,views.AreaView.as_view() ,name='index'),
]