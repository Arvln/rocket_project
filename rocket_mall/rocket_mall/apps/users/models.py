#AbstractUser為django默認用戶模型類
from django.contrib.auth.models import AbstractUser
from django.db import models

from utils.models import BaseModel

# Create your models here.

#通過模型類建表需要寫完整字段約束，如果數據庫中已建好表，則只需要建立模型類和數據庫的映射關係
class User(AbstractUser):
    """加入需求的手機號碼字段"""
    mobile = models.CharField(max_length=10 ,unique=True ,blank=True ,verbose_name='手機號碼')
    email_active = models.BooleanField(default=False ,verbose_name='Email驗證狀態' )
    default_address = models.ForeignKey('Address' ,related_name='users' ,null=True ,blank=True ,
                                        on_delete=models.SET_NULL ,verbose_name='默認地址' )

    class Meta:
       db_table = 'tb_user' #定義表名
       verbose_name = '用戶'
       verbose_name_plural = verbose_name

    #調試用戶名
    def __str__(self):
        return self.username

class Address(BaseModel):
    """用戶地址"""
    #外鍵保存的是id
    user = models.ForeignKey(User ,on_delete=models.CASCADE ,related_name='addresses' ,verbose_name='用戶' )
    title = models.CharField(max_length=20 ,verbose_name='地址名稱' )
    receiver = models.CharField(max_length=20 ,verbose_name='收貨人' )
    mobile = models.CharField(max_length=10, verbose_name='手機' )
    email = models.CharField(max_length=30, null=True, blank=True, default='', verbose_name='電子信箱')
    area = models.ForeignKey('areas.Area' ,on_delete=models.PROTECT ,related_name='area_addresses' , verbose_name='區域' )
    city = models.ForeignKey('areas.Area' ,on_delete=models.PROTECT ,related_name='city_addresses' , verbose_name='縣市' )
    district = models.ForeignKey('areas.Area' ,on_delete=models.PROTECT ,related_name='district_addresses' , verbose_name='郵遞區號' )
    place = models.CharField(max_length=50 ,verbose_name='地址' )
    is_deleted = models.BooleanField(default=False ,verbose_name='邏輯刪除' )

    class Meta:
        db_table = 'tb_address'
        verbose_name = '用戶地址'
        verbose_name_plural = verbose_name
        ordering = ['-update_time']