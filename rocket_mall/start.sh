#!/bin/bash
#蒐集項目靜態文件
python manage.py collectstatic --noinput&&
#數據遷移
python manage.py makemigrations&&
python manage.py migrate&&
#elasticsearch建立索引
echo y|python manage.py rebuild_index&&
#修改日誌文件權限
chmod 666 logs/rocket.log&&
#uwsgi啟動django服務
uwsgi --ini /var/www/html/rocket_mall/uwsgi.ini&&
#celery啟動異步服務
celery -A celery_tasks.main worker -l info -c 5&&
celery -A celery_tasks.main worker -l info -P eventlet -c 500