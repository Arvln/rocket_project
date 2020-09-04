from django.shortcuts import render
from django.views import View

# Create your views here.

class RegisterView(View):
    """用戶註冊類視圖"""
    def get(self ,request ):
        """提供用戶註冊頁面"""
        pass