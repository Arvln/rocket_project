from pydantic import BaseModel
from datetime import datetime
from typing import List


class Goods(BaseModel):
    id:int
    create_time:datetime
    update_time:datetime
    name:str
    sales:int
    comments:int
    desc_detail:str
    desc_pack:str
    brand_id:int
    category1_id:int
    category2_id:int
    category3_id:int
    class Config:
        orm_mode = True
#請求體結構
class GoodsSpecBase(BaseModel):
    name: str
    goods_id: int

class GoodsSpecification(GoodsSpecBase):
    id:int
    goods:List[Goods] = []
    class Config:
        orm_mode = True