from django.contrib.auth import login
from django.shortcuts import render, redirect
from django.urls import reverse
from django.views import View
from django.db import DatabaseError
from django.http import HttpResponseForbidden ,JsonResponse

from users.models import User
from utils.response_code import RETCODE
import re

# Create your views here.

class RegisterView(View):
    """用戶註冊類視圖"""
    def get(self ,request ):
        """提供用戶註冊頁面"""
        return render(request ,'register.html' )

    def post(self ,request ):
        """實現用戶註冊主邏輯"""
        #接收參數
        username = request.POST.get('username')
        password = request.POST.get('password')
        password2 = request.POST.get('password2')
        mobile = request.POST.get('mobile')
        allow = request.POST.get('allow')
        #校驗參數，保障後端安全
        #參數是否齊全
        #參數是否合規
        if not all(['username','password','password2','mobile','allow']):
            return HttpResponseForbidden('缺少必傳參數')
        if not re.match('^[a-zA-Z0-9_-]{5,20}$' ,username ):
            return HttpResponseForbidden('請輸入5~20個字符的用戶名稱')
        if not re.match('^[a-zA-Z0-9_-]{8,12}$', password):
            return HttpResponseForbidden('請輸入8位到12位的密碼')
        if password != password2:
            return HttpResponseForbidden('請檢查與原先輸入的密碼是否相符')
        if not re.match('^09\d{8}$' ,mobile ):
            return HttpResponseForbidden('您輸入的手機號碼格式不正確')
        if allow != 'on':
            return HttpResponseForbidden('請勾選同意RockeT使用合約')
        #實現業務邏輯
        try:
            user = User.objects.create_user(username=username ,password=password ,mobile=mobile )
        except DatabaseError:
            return render(request ,'register.html' ,{'register_errmsg':'註冊失敗'})

        #實現狀態保持
        login(request ,user )
        #返回響應:重定向到首頁
        return redirect(reverse('contents:index'))

class UsercountView(View):

    def get(self ,request ,username ):
        """查詢用戶名數量"""
        #查詢用戶名數
        count = User.objects.filter(username=username).count()
        #返回響應
        return JsonResponse({'code':RETCODE.OK ,'errmsg':'OK' ,'count':count })

class MobilecountView(View):

    def get(self ,request ,mobile ):
        """查詢手機號碼數量"""
        #查詢手機號碼數
        count = User.objects.filter(mobile=mobile).count()
        #返回響應
        return JsonResponse({'code':RETCODE.OK ,'errmsg':'OK' ,'count':count })