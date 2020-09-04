from django.shortcuts import render
from django.views import View
from django.http import HttpResponse


from verifications.libs.captcha.captcha import captcha
from django_redis import get_redis_connection
from verifications import constants

# Create your views here.

class ImagecodeView(View):
    """圖形驗證碼"""
    def get(self, request, uuid):
        """獲取圖形驗證碼"""
        # 生成圖形驗證碼
        text ,image = captcha.generate_captcha()
        # 保存圖形驗證碼
        conn = get_redis_connection('verify_code')
        conn.setex('img_%s' %uuid ,constants.IMAGE_CODE_EXPIRES ,text )
        # 返回響應
        return HttpResponse(image ,content_type='image/jpg')