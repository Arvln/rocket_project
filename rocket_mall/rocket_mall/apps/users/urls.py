from django.conf.urls import url
from . import views

urlpatterns = [
    #提交註冊資料後端接口
    url(r'^api/register_info/post/$' ,views.RegisterView.as_view() ,name='register'),
    #用戶名數量查詢後端接口
    url(r'^api/usernames/get/(?P<username>[a-zA-Z0-9_-]{5,20})/$', views.UsercountView.as_view()),
    #手機號碼數量查詢後端接口
    url(r'^api/mobiles/get/(?P<mobile>09[\d]{8})/$', views.MobilecountView.as_view()),
    #用戶登入後端接口
    url(r'^api/login_info/$' ,views.LoginView.as_view() ,name='login' ),
    #校驗登入用戶後端接口
    url(r'^api/login_info/get/$' ,views.CheckusermsgView.as_view() ),
    #退出登入後端接口
    url(r'^api/logout/$' ,views.LogoutView.as_view() ,name='logout' ),
    #用戶中心後端接口
    url(r'^api/user_center_info/get/$' ,views.UserInfoView.as_view() ,name='info' ),
    #更新用戶Email後端接口
    url(r'^api/email/put/$' ,views.EmailView.as_view() ),
    #驗證用戶Email後端接口
    url(r'^api/email/verification/get/$' ,views.VerifyEmailView.as_view() ),
    #獲取用戶收貨地址頁面後端接口
    url(r'^api/addresses/get/$' ,views.AddressView.as_view() ,name='address' ),
    #新增用戶收貨地址後端接口
    #url(r'^api/addresses/post/$' ,views.AddressCreateView.as_view() ),
    #修改或刪除用戶收貨地址後端接口
    #url(r'^api/addresses/put_delete/(?P<address_id>\d+)/$' ,views.UpdateDestroyAddressView.as_view() ),
    #設置默認地址後端接口
    #url(r'^api/addresses/default/put/(?P<address_id>\d+)/$' ,views.DefaultAddressView.as_view() ),
    #修改地址標題後端接口
    #url(r'^api/addresses/title/put/(?P<address_id>\d+)/$' ,views.UpdateAddressTitleView.as_view() ),
]