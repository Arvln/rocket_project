#Celery的入口
from celery import Celery

#創建Celery實例
celery_app = Celery('rocket')

#加載配置
celery_app.config_from_object('celery_tasks.config')

#註冊任務
celery_app.autodiscover_tasks(['celery_tasks.sms'])