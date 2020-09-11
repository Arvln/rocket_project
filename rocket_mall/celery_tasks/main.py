#Celery的入口
from celery import Celery

#celery環境配置，讀取django配置文件dev.py
import os
if not os.getenv('DJANGO_SETTINGS_MODULE'):
    os.environ['DJANGO_SETTINGS_MODULE'] = 'rocket_mall.settings.dev'

#創建Celery實例
celery_app = Celery('rocket')

#加載配置
celery_app.config_from_object('celery_tasks.config')

#註冊任務
celery_app.autodiscover_tasks(['celery_tasks.sms' ,'celery_tasks.email' ])