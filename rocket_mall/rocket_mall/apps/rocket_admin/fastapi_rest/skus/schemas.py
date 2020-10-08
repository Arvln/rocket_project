from pydantic import BaseModel
from decimal import Decimal
from typing import List


class Goods(BaseModel):
    id:int
    name:str
    class Config:
        orm_mode = True

class SpecificationOption(BaseModel):
    id:int
    name:str
    class Config:
        orm_mode = True

class GoodsSpecification(BaseModel):
    id:int
    name:str
    goods:Goods = None
    options:SpecificationOption = None
    class Config:
        orm_mode = True

class SKUSpecification(BaseModel):
    spec_id:int
    option_id:int
    class Config:
        orm_mode = True

class GoodsCategory(BaseModel):
    id:int
    name:str
    class Config:
        orm_mode = True

class SKURequestBody(BaseModel):
    name:str
    goods_id:int
    caption:str
    category_id:int
    price:Decimal
    cost_price:Decimal
    market_price:Decimal
    stock:int
    is_launched:bool

class SKU(SKURequestBody):
    id:int
    sales:int
    goods:Goods = None
    category:GoodsCategory = None
    specs:List[SKUSpecification] = []
    class Config:
        orm_mode = True