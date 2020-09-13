"""rocket_mall URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from django.conf.urls import url

urlpatterns = [
    path('admin/', admin.site.urls),
    # 用戶模塊
    url(r'^', include(('users.urls', 'users'), namespace='users')),
    # 首頁模塊
    url(r'^', include(('contents.urls', 'contents'), namespace='contents')),
    # 驗證模塊
    url(r'^', include(('verifications.urls', 'verifications'))),
    # 第三方登錄模塊
    url(r'^', include(('oauth.urls', 'oauth') ,namespace='oauth')),
    # 用戶收貨地址模塊
    url(r'^', include(('areas.urls' , 'areas'))),
]
