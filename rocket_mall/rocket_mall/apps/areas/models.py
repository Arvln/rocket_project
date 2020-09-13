from django.db import models

# Create your models here.


class Area(models.Model):
    """用戶收貨地址"""
    name = models.CharField(max_length=20 ,verbose_name='名稱' )
    #自關聯表結構
    parent = models.ForeignKey('self' ,on_delete=models.SET_NULL ,related_name='subs' ,null=True ,blank=True ,verbose_name='上級行政區' )

    class Meta:
        db_table = 'tb_areas'
        verbose_name = '行政區'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.name

