#AbstractUser為django默認用戶模型類
from django.contrib.auth.models import AbstractUser
from django.db import models

# Create your models here.
class User(AbstractUser):
    """加入需求的手機號碼字段"""
    mobile = models.CharField(max_length=10 ,unique=True ,verbose_name='手機號碼')

    class Meta:
       db_table = 'tb_user' #定義表名
       verbose_name = '用戶'
       verbose_name_plural = verbose_name

    #調試用戶名
    def __str__(self):
        return self.username