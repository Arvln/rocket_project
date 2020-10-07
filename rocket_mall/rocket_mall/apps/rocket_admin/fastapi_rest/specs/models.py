from sqlalchemy import Column, Integer, String, DateTime, Boolean, Text, ForeignKey
from sqlalchemy.orm import relationship
from datetime import datetime

from .databases import Base


#模型類和數據庫表映射
class Goods(Base):
    """商品SPU"""
    __tablename__ = 'tb_goods'

    id = Column(Integer, primary_key=True, doc='商品ID')
    create_time = Column(DateTime, default=datetime.now, doc='創建時間')
    update_time = Column(DateTime, default=datetime.now, onupdate=datetime.now, doc='更新時間')
    name = Column(String(50), doc='名稱')
    sales = Column(Integer, default=0, doc='銷量')
    comments = Column(Integer, default=0, doc='評價數')
    desc_detail = Column(Text, doc='詳細介紹')
    desc_pack = Column(Text, doc='包裝訊息')
    desc_service = Column(Text, doc='售后服務')
    brand_id = Column(Integer, doc='品牌')
    category1_id = Column(Integer, doc='一級類别')
    category2_id = Column(Integer, doc='二級類别')
    category3_id = Column(Integer, doc='三級類别')

    specs = relationship('GoodsSpecification', back_populates='goods')

class GoodsSpecification(Base):
    """商品規格"""
    __tablename__ = 'tb_goods_specification'

    id = Column(Integer, primary_key=True, doc='規格ID')
    create_time = Column(DateTime, default=datetime.now, doc='創建時間')
    update_time = Column(DateTime, default=datetime.now, onupdate=datetime.now, doc='更新時間')
    name = Column(String(20), doc='規格名稱')
    goods_id = Column(Integer, ForeignKey('tb_goods.id'), doc='商品ID')

    goods = relationship('Goods', back_populates='specs')