from django.core.mail import send_mail

from settings.dev import EMAIL_FROM
from celery_tasks.main import celery_app

@celery_app.task(bind=True ,name='send_verify_mail' ,retry_backoff=2 )
def send_verify_mail(self ,to_email ,verify_url ):
    """發郵件的異步任務"""
    subject = '羅奇商城郵箱驗證'
    html_message = '<p>感謝您使用羅奇商城，</p>' \
                   '<p>您的郵箱為 : %s ，請點擊連結驗證您的郵箱: </p>' \
                   '<p><a href="%s">%s</a></p>' % (to_email ,verify_url ,verify_url )
    try:
        send_mail(subject ,'' ,EMAIL_FROM ,[to_email] ,html_message=html_message )
    except Exception as e:
        #錯誤重試次數
        raise self.retry(exe=e ,max_retries=3 )
