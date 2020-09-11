from django.core.mail import send_mail

from settings.dev import EMAIL_FROM
from celery_tasks.main import celery_app

@celery_app.task(name='send_verify_mail')
def send_verify_mail(to_email ,verify_url ):
    """發郵件的異步任務"""
    subject = '羅奇商城郵箱驗證'
    html_message = '<p>感謝您使用羅奇商城，</p>' \
                   '<p>您的郵箱為 : %s ，請點擊連結驗證您的郵箱: </p>' \
                   '<p><a href="%s">%s</a></p>' % (to_email ,verify_url ,verify_url )

    send_mail(subject ,'' ,EMAIL_FROM ,[to_email] ,html_message=html_message )