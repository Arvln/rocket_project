from django.db import models

from utils.models import BaseModel
from users.models import User ,Address
from goods.models import SKU

# Create your models here.


class OrderInfo(BaseModel):
    """訂單資訊"""
    PAY_METHODS_ENUM = {
        "CASH": 1,
        "ALIPAY": 2,
        "LINEPAY": 3,
    }
    PAY_METHOD_CHOICES = (
        (1, "貨到付款"),
        (2, "支付寶"),
        (3, "LinePay"),
    )
    ORDER_STATUS_ENUM = {
        "UNPAID": 1,
        "UNSEND": 2,
        "UNRECEIVED": 3,
        "UNCOMMENT": 4,
        "FINISHED": 5
    }
    ORDER_STATUS_CHOICES = (
        (1, "待支付"),
        (2, "待發貨"),
        (3, "待收貨"),
        (4, "待評價"),
        (5, "已完成"),
        (6, "已取消"),
    )
    order_id = models.CharField(max_length=64, primary_key=True, verbose_name="訂單號碼")
    user = models.ForeignKey(User, on_delete=models.PROTECT, verbose_name="下單用戶")
    address = models.ForeignKey(Address, on_delete=models.PROTECT, verbose_name="收貨地址")
    total_count = models.IntegerField(default=1, verbose_name="商品總數")
    total_amount = models.DecimalField(max_digits=10, decimal_places=2, verbose_name="商品總金額")
    freight = models.DecimalField(max_digits=10, decimal_places=2, verbose_name="運費")
    pay_method = models.SmallIntegerField(choices=PAY_METHOD_CHOICES, default=1, verbose_name="支付方式")
    status = models.SmallIntegerField(choices=ORDER_STATUS_CHOICES, default=1, verbose_name="訂單狀態")

    class Meta:
        db_table = "tb_order_info"
        verbose_name = '訂單基本資料'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.order_id


class OrderGoods(BaseModel):
    """訂單商品"""
    SCORE_CHOICES = (
        (0, '0顆星'),
        (1, '1顆星'),
        (2, '2顆星'),
        (3, '3顆星'),
        (4, '4顆星'),
        (5, '5顆星'),
    )
    order = models.ForeignKey(OrderInfo, related_name='skus', on_delete=models.CASCADE, verbose_name="訂單")
    sku = models.ForeignKey(SKU, on_delete=models.PROTECT, verbose_name="訂單商品")
    count = models.IntegerField(default=1, verbose_name="數量")
    price = models.DecimalField(max_digits=10, decimal_places=2, verbose_name="單價")
    comment = models.TextField(default="", verbose_name="評價資訊")
    score = models.SmallIntegerField(choices=SCORE_CHOICES, default=5, verbose_name='滿意度評分')
    is_anonymous = models.BooleanField(default=False, verbose_name='是否匿名評價')
    is_commented = models.BooleanField(default=False, verbose_name='是否評價')

    class Meta:
        db_table = "tb_order_goods"
        verbose_name = '訂單商品'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.sku.name