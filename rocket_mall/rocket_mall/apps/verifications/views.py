from django.shortcuts import render
from django.views import View
from django.http import HttpResponse ,JsonResponse ,HttpResponseForbidden

from verifications.libs.captcha.captcha import captcha
from django_redis import get_redis_connection
from verifications import constants
from utils.response_code import RETCODE
from verifications.sms import send
import random

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

class SMScodeView(View):
    """簡訊驗證碼"""
    def get(self ,request ,mobile ):
        """獲取簡訊驗證碼"""
        #接收參數
        img_code_client = request.GET.get('img_code')
        uuid = request.GET.get('uuid')
        #校驗參數，參數錯誤將無法順利通過提取和比對圖形驗證碼邏輯，此處暫不校驗
        if not all([img_code_client ,uuid ]):
            return HttpResponseForbidden('缺少必傳參數')
        #提取圖形驗證碼
        conn = get_redis_connection('verify_code')
        img_code_server = conn.get('img_%s' %uuid )
        if img_code_server is None:
            return JsonResponse({'code':RETCODE.IMAGECODEERR ,'errmsg':'圖形驗證碼已失效' })
        #刪除圖形驗證碼，避免惡意用戶在時效內測試圖形驗證碼
        conn.delete('img_%s' %uuid )
        #比對圖形驗證碼
        img_code_server = img_code_server.decode() #將redis返回的bytes類型轉str類型
        if img_code_server.lower() != img_code_client.lower():
            return JsonResponse({'code':RETCODE.IMAGECODEERR ,'errmsg':'請確認圖形驗證碼是否輸入正確'})
        #生成簡訊驗證碼
        sms_code = '%06d' %random.randint(0 ,999999 )
        #保存簡訊驗證碼
        conn.setex('sms_%s' %mobile ,constants.SMS_CODE_EXPIRES ,sms_code )
        #發送簡訊驗證碼
        send(mobile ,sms_code ,constants.SMS_CODE_EXPIRES // 60 )
        # 返回響應
        return JsonResponse({'code':RETCODE.OK ,'errmsg':'OK'})