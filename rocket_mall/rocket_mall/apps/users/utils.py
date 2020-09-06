from django.contrib.auth.backends import ModelBackend
from django.shortcuts import render
from django.http import JsonResponse
import re

from users.models import User
from utils.response_code import RETCODE

def get_user_by_account(request ,account ):
    """通過帳號獲取用戶"""
    #校驗參數，從限制條件嚴格的參數開始校驗
    try:
        if re.match('^09[\d]{8}$', account):
            #username == mobile
            user = User.objects.get(mobile=account)
        # elif re.match('^[\w.-]+@[\w-]+(.[\w_-]+)+$', account):
            #username == Email
        #     pass
        else:
            #username == username
            user = User.objects.get(username=account)
    except Exception:
        if request.method == 'GET':
            return JsonResponse({'code': RETCODE.USERERR, 'errmsg': '您的帳號尚未註冊，現在註冊使用RockeT?'})
        else:
            return render(request ,'login.html' ,{'errmsg':'您的帳號尚未註冊，現在註冊使用RockeT?'})
    else:
        return user

class LoginBackend(ModelBackend):
    """自定義用戶認證後端"""
    def authenticate(self, request, username=None, password=None, **kwargs):
        """重寫用戶認證方法"""
        # 是否能查詢到用戶
        res = get_user_by_account(request ,username )
        if type(res) == User:
            user = res
        else:
            return res
        # 查詢到用戶後，校驗密碼是否正確
        if user and user.check_password(password):
            # 返回user
            return user
        else:
            if request.method == 'GET':
                return JsonResponse({'code': RETCODE.PWDERR, 'errmsg': '請確認用戶名或密碼是否正確'})
            else:
                return render(request, 'login.html', {'errmsg': '請確認用戶名稱或密碼是否正確'})

