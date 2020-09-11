from django.contrib.auth.mixins import LoginRequiredMixin
from django.http import JsonResponse

from utils.response_code import RETCODE

class LoginRequiredJsonMixin(LoginRequiredMixin):
    """自定義判斷用戶是否登入的類"""
    def handle_no_permission(self):
        """響應json數據"""
        return JsonResponse({'code':RETCODE.SESSIONERR ,'errmsg':'請登錄後再試' })