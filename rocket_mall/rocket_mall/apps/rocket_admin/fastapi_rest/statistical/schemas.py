from pydantic import BaseModel
from datetime import datetime
from decimal import Decimal


class User(BaseModel):
    id : int
    password : str
    last_login : datetime = None #模型類默認可為空，返回的數據類型也應指定可為空
    is_superuser : bool
    username : str
    first_name : str
    last_name : str
    email : str
    is_staff : bool
    is_active : bool
    date_joined : datetime
    mobile : str
    email_active : int
    default_address_id : int = None
    #兼容ORM模型類對象
    class Config:
        orm_mode = True

class OrderInfo(BaseModel):
    create_time:datetime
    update_time:datetime
    order_id:str
    total_count:int
    total_amount:Decimal
    freight:Decimal
    pay_method:int
    status:int
    class Config:
        orm_mode = True

class GoodsVisit(BaseModel):
    id:int
    create_time:datetime
    update_time:datetime
    count:int
    date:datetime
    category_id:int
    class Config:
        orm_mode = True