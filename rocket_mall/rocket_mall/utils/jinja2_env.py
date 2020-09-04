from jinja2 import Environment
from django.urls import reverse
from django.contrib.staticfiles.storage import staticfiles_storage

def jinja2_environment(**options):
    """jinja2環境"""
    env = Environment(**options)
    env.globals.update({
        "static":staticfiles_storage.url, #獲取靜態文件前綴
        "url":reverse, #反向解析
    })
    return env