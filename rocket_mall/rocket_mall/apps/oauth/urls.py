from django.conf.urls import url
from . import views

urlpatterns = [
    #獲取line用戶登入授權頁面後端接口
    url(r'^api/line/login_url/get/$', views.LineLoginView.as_view()),
    #按照授權結果，進行line用戶登入後端接口
    url(r'^api/line/login/$', views.LineRegisterView.as_view(), name='line_login'),
]