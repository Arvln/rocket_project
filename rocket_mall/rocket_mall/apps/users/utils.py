from django.contrib.auth.backends import ModelBackend
from django.shortcuts import render
from django.http import JsonResponse
import re

from users.models import User
from utils.response_code import RETCODE
from itsdangerous import TimedJSONWebSignatureSerializer as Serializer
from settings.dev import SECRET_KEY ,EMAIL_VERIFY_URL
from . import constants

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

def generate_verify_email_url(user):
    """生成商城郵箱認證連結"""
    # 創建序列化器對象
    s = Serializer(SECRET_KEY ,constants.VERIFY_EMAIL_TOKEN_EXPIRES )
    # 準備用戶識別數據
    data = {
        'user_id':user.id ,
        'email':user.email ,
    }
    # 序列化數據
    token = s.dumps(data).decode()
    # 返回簽名數據
    return EMAIL_VERIFY_URL + '?token=' + token

def check_verify_email_url(token):
    """提取郵箱驗證連結數據"""
    # 創建序列化器對象
    s = Serializer(SECRET_KEY ,constants.VERIFY_EMAIL_TOKEN_EXPIRES )
    # 準備待反序列化數據
    token = token
    # 判斷token是否過期
    try:
        data = s.loads(token)
    except Exception:
        return None
    else:
        id = data.get('user_id')
        email = data.get('email')
        try:
            # 若user存在則返回user
            user = User.objects.get(id=id ,email=email )
        except Exception:
            return None
    return user