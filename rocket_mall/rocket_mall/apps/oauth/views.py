from django.contrib.auth import login
from django.shortcuts import render ,redirect
from django.urls import reverse
from django.http import JsonResponse ,HttpResponseServerError ,HttpResponseForbidden
from django.views import View
from settings.dev import Line_ChannelID
import logging ,re

from oauth.utils import get_id_token ,get_profile_information ,generate_access_token ,check_access_token
from oauth.models import OAuthLineUser
from users.models import User
from . import constants
from carts.utils import merge_carts_cookies_redis

# Create your views here.


class LineLoginView(View):
    """拼接獲取line登入頁面連結"""
    def get(self ,request ):

        #獲取查詢參數
        next = request.GET.get('next')
        redirect_uri = 'http://192.168.126.130:8000' + reverse('oauth:line_login')
        #拼接查詢地址
        login_url = 'https://access.line.me/oauth2/v2.1/authorize?response_type=code&client_id=' + Line_ChannelID + '&redirect_uri=' + redirect_uri + '&state=' + next + '&scope=profile%20openid'
        #返回響應
        return JsonResponse({'login_url':login_url})

logger = logging.getLogger('django')

class LineRegisterView(View):
    """按照授權結果，進行line用戶登入"""
    def get(self ,request ):

        #提取參數
        code = request.GET.get('code')
        error = request.GET.get('error')
        state = request.GET.get('state')
        #判斷用戶是否授權
        if error:
            return redirect(reverse('users:login'))
        try:
            # 請求line接口獲取id_token
            id_token = get_id_token(code)
            # 請求line接口驗證並解碼id_token
            picture ,userid ,user_messages_dict = get_profile_information(id_token ,state )
        except Exception as e:
            logger.error(e)
            return HttpResponseServerError('OAuth2.0認證失敗')
        #判斷用戶是否存在
        try:
            oauth_line_user = OAuthLineUser.objects.get(userid=userid)
        except Exception:
            #用戶未用line登入過
            #簽名用戶數據
            access_token = generate_access_token(user_messages_dict)
            #構造響應數據
            contents = {
                'access_token':access_token ,
                'picture':picture ,
            }
            #返回用戶加密數據和line用戶註冊頁面
            return render(request ,'line_register.html' ,contents )
        else:
            #實現狀態保持:oauth_line_user.user代表從oauth_line_user中找出對應的用戶模型類對象
            login(request ,oauth_line_user.user )
            #重定向到指定頁面:state
            if state == '/':
                response = redirect(reverse('contents:index'))
            else:
                response = redirect(state)
            #將用戶登入資訊寫入到cookies
            response.set_cookie('username' ,oauth_line_user.user.username ,constants.LOGIN_COOKIE_EXPIRES )
            response.set_cookie('photo_url' ,oauth_line_user.photo_url ,constants.LOGIN_COOKIE_EXPIRES )

            #用戶登錄成功後，同樣商品將cookies購物車數據覆蓋寫入redis
            response = merge_carts_cookies_redis(request, oauth_line_user.user, response)
            #返回響應
            return response

    def post(self ,request ):
        """line登入用戶註冊"""
        #提取參數
        username = request.POST.get('username')
        mobile = request.POST.get('mobile')
        allow = request.POST.get('allow')
        access_token = request.POST.get('access_token')
        user_messages_dict = check_access_token(access_token)
        #校驗參數
        if not all([username ,mobile ,allow ,access_token ]):
            return HttpResponseForbidden('缺少必傳參數')
        if not re.match('^[a-zA-Z0-9_-]{5,20}$' ,username ):
            return HttpResponseForbidden('請輸入5~20個字符的用戶名稱')
        count = User.objects.filter(username=username).count()
        if count == 1:
            return HttpResponseForbidden('該用戶名稱已存在')
        if not re.match('^09\d{8}$' ,mobile ):
            return HttpResponseForbidden('您輸入的手機號碼格式不正確')
        if allow != 'on':
            return HttpResponseForbidden('請勾選同意RockeT使用合約')
        if not user_messages_dict:
            return HttpResponseForbidden('userid已失效')
        #實現主體業務邏輯:創建line登入用戶
        name = user_messages_dict.get('name')
        photo_url = user_messages_dict.get('picture')
        userid = user_messages_dict.get('sub')
        state = user_messages_dict.get('state')
        try:
            #用戶不存在，創建新用戶
            user = User.objects.create_user(username=username ,mobile=mobile )
            #寫入用戶line登入資訊
            OAuthLineUser.objects.create(user=user ,name=name ,photo_url=photo_url ,userid=userid )
        except Exception as e:
            logger.error(e)
            return render(request ,'login.html' ,{'errmsg':'創建用戶失敗'})
        #實現狀態保持
        login(request ,user )
        #重定向到指定頁面:state
        #構造響應數據
        if state == '/':
            response = redirect(reverse('users:info'))
        else:
            response = redirect(state)
        #將用戶登入資訊寫入到cookies
        response.set_cookie('username' ,username ,constants.LOGIN_COOKIE_EXPIRES )
        response.set_cookie('photo_url' ,photo_url ,constants.LOGIN_COOKIE_EXPIRES )

        #用戶登錄成功後，同樣商品將cookies購物車數據覆蓋寫入redis
        response = merge_carts_cookies_redis(request, user, response)
        #返回響應
        return response