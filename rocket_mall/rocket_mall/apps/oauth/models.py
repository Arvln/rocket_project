from django.db import models

from utils.models import BaseModel

# Create your models here.


class OAuthLineUser(BaseModel):
    """line login"""
    user = models.ForeignKey('users.User' ,on_delete=models.CASCADE ,verbose_name='用戶' )
    userid = models.CharField(max_length=64 ,unique=True ,verbose_name='userid' ,db_index=True )
    name = models.CharField(max_length=50 ,verbose_name='line帳號用戶名稱' )
    photo_url = models.CharField(max_length=200 ,default='' ,null=True ,blank=True ,verbose_name='用戶照片' )

    class Meta:
        db_table = 'tb_line_user'  # 定義表名
        verbose_name = 'line用戶'
        verbose_name_plural = verbose_name

class OAuthGoogleUser(BaseModel):
    """google login"""
    user = models.ForeignKey('users.User', on_delete=models.CASCADE, verbose_name='用戶')
    userid = models.CharField(max_length=64, unique=True, verbose_name='userid', db_index=True)
    name = models.CharField(max_length=50, verbose_name='google帳號用戶名稱')
    photo_url = models.CharField(max_length=200, default='', null=True, blank=True, verbose_name='用戶照片')

    class Meta:
        db_table = 'tb_google_user'  # 定義表名
        verbose_name = 'google用戶'
        verbose_name_plural = verbose_name

class OAuthFBUser(BaseModel):
    """facebook login"""
    user = models.ForeignKey('users.User', on_delete=models.CASCADE, verbose_name='用戶')
    userid = models.CharField(max_length=64, unique=True, verbose_name='userid', db_index=True)
    name = models.CharField(max_length=50, verbose_name='fb帳號用戶名稱')
    photo_url = models.CharField(max_length=200, default='', null=True, blank=True, verbose_name='用戶照片')

    class Meta:
        db_table = 'tb_fb_user'  # 定義表名
        verbose_name = 'fb用戶'
        verbose_name_plural = verbose_name