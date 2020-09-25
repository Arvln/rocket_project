from django.db import models

from utils.models import BaseModel
from orders.models import OrderInfo

# Create your models here.


class Payment(BaseModel):
    """支付資訊"""
    order = models.ForeignKey(OrderInfo, on_delete=models.CASCADE, verbose_name='訂單')
    trade_id = models.CharField(max_length=100, unique=True, null=True, blank=True, verbose_name="支付標號")

    class Meta:
        db_table = 'tb_payment'
        verbose_name = '支付資訊'
        verbose_name_plural = verbose_name