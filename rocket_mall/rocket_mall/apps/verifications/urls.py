from django.conf.urls import url
from . import views

urlpatterns = [
    #獲取圖形驗證碼後端接口
    url(r'^api/image_codes/(?P<uuid>[0-9a-f]{8}(-[0-9a-f]{4}){3}-[0-9a-f]{12})/$' ,views.ImagecodeView.as_view() ),
]