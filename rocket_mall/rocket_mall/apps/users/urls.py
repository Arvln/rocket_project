from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^register/$' ,views.RegisterView.as_view() ,name='register'),
    # 用戶名數量查詢後端接口
    url(r'^api/usernames/count/(?P<username>[a-zA-Z0-9_-]{5,20})/$', views.UsercountView.as_view()),
    # 手機號碼數量查詢後端接口
    url(r'^api/mobiles/count/(?P<mobile>09[\d]{8})/$', views.MobilecountView.as_view()),
]