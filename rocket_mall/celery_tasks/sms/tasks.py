from celery_tasks.sms.sms import send
from . import constants
from celery_tasks.main import celery_app

#定義任務
#使用裝飾器裝飾異步任務，保證celery識別任務
@celery_app.task(name='send_sms_code')
def send_sms_code(mobile ,sms_code ):
    """發送簡訊驗證碼的異步請求"""

    send_ret = send(mobile, sms_code, constants.SMS_CODE_EXPIRES // 60)
    return send_ret