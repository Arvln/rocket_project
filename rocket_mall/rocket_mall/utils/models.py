from django.db import models


class BaseModel(models.Model):
    """為模型類補充字段"""

    create_time = models.DateTimeField(auto_now_add=True ,verbose_name='創建時間' )
    update_time = models.DateTimeField(auto_now=True ,verbose_name='更新時間' )

    class Meta:
        abstract = True #抽象模型類，數據遷移時不創建
