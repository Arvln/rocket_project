from pydantic import BaseModel
from decimal import Decimal
from datetime import datetime
from typing import List


#多層嵌套返回
class SKU(BaseModel):
    name:str
    default_image_url:str
    class Config:
        orm_mode = True

class OrderGoods(BaseModel):
    count:int
    price:int
    sku:SKU = None
    class Config:
        orm_mode = True


class OrderInfoList(BaseModel):
    order_id:str
    create_time:datetime
    class Config:
        orm_mode = True

class User(BaseModel):
    username:str
    class Config:
        orm_mode = True

class OrderStatusRequestBody(BaseModel):
    status:int

class OrderStatus(OrderStatusRequestBody):
    order_id:str
    class Config:
        orm_mode = True

class OrderInfo(OrderInfoList):
    user:User = None
    total_count:int
    total_amount:int
    freight:Decimal
    pay_method:int
    status:int
    skus:List[OrderGoods] = []
    class Config:
        orm_mode = True