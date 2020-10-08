from sqlalchemy import Column, Integer, String, DateTime, Boolean, Text, ForeignKey, DECIMAL
from sqlalchemy.orm import relationship
from datetime import datetime

from .databases import Base


#模型類和數據庫表映射
class SpecificationOption(Base):
    """規格選項"""
    __tablename__ = 'tb_specification_option'

    id = Column(Integer, primary_key=True, doc='規格選項ID')
    create_time = Column(DateTime, default=datetime.now, doc='創建時間')
    update_time = Column(DateTime, default=datetime.now, onupdate=datetime.now, doc='更新時間')
    name = Column('value', String(20), doc='選項值')
    spec_id = Column(Integer, ForeignKey('tb_goods_specification.id'))

    specs = relationship('GoodsSpecification', back_populates='options')
    sku_spec = relationship('SKUSpecification', back_populates='option')

class GoodsSpecification(Base):
    """商品規格"""
    __tablename__ = 'tb_goods_specification'

    id = Column(Integer, primary_key=True, doc='規格ID')
    create_time = Column(DateTime, default=datetime.now, doc='創建時間')
    update_time = Column(DateTime, default=datetime.now, onupdate=datetime.now, doc='更新時間')
    name = Column(String(20), doc='規格名稱')
    goods_id = Column(Integer, ForeignKey('tb_goods.id'), doc='商品ID')

    goods = relationship('Goods', back_populates='specs')
    sku_spec = relationship('SKUSpecification', back_populates='spec')
    options = relationship('SpecificationOption', back_populates='specs')

class Goods(Base):
    """商品SPU"""
    __tablename__ = 'tb_goods'

    id = Column(Integer, primary_key=True, doc='商品ID')
    name = Column(String(50), doc='名稱')

    goods = relationship('SKU', back_populates='goods')
    specs = relationship('GoodsSpecification', back_populates='goods')

class SKUSpecification(Base):
    """SKU具體規格"""
    __tablename__ = 'tb_sku_specification'

    id = Column(Integer, primary_key=True, doc='SKU規格ID')
    create_time = Column(DateTime, default=datetime.now, doc='創建時間')
    update_time = Column(DateTime, default=datetime.now, onupdate=datetime.now, doc='更新時間')
    option_id = Column(Integer, ForeignKey('tb_specification_option.id'), doc='規格值')
    sku_id = Column(Integer, ForeignKey('tb_sku.id'), doc='sku')
    spec_id = Column(Integer, ForeignKey('tb_goods_specification.id'), doc='規格名稱')

    option = relationship('SpecificationOption', back_populates='sku_spec')
    sku = relationship('SKU', back_populates='specs')
    spec = relationship('GoodsSpecification', back_populates='sku_spec')

class SKU(Base):
    """SKU商品"""
    __tablename__ = 'tb_sku'

    id = Column(Integer, primary_key=True, doc='SKU商品ID')
    create_time = Column(DateTime, default=datetime.now, doc='創建時間')
    update_time = Column(DateTime, default=datetime.now, onupdate=datetime.now, doc='更新時間')
    name = Column(String(300), doc='名稱')
    caption = Column(String(100), doc='副標題')
    price = Column(DECIMAL(10,2), doc='單價')
    cost_price = Column(DECIMAL(10, 2), doc='進價')
    market_price = Column(DECIMAL(10, 2), doc='市場價')
    stock = Column(Integer, default=0, doc='庫存')
    sales = Column(Integer, default=0, doc='銷量')
    comments = Column(Integer, default=0, doc='評價數')
    is_launched = Column(Boolean, default=True, doc='是否上架銷售')
    default_image_url = Column(String(200), default='', doc='默認圖片')
    category_id = Column(Integer, ForeignKey('tb_goods_category.id'), doc='商品分類ID')
    goods_id = Column(Integer, ForeignKey('tb_goods.id'), doc='商品ID')

    #外鍵命名須跟schemas.py文件中數據模型類一致才能讀取
    goods = relationship('Goods', back_populates='goods')
    category = relationship('GoodsCategory', back_populates='sku')
    specs = relationship('SKUSpecification', back_populates='sku')

class GoodsCategory(Base):
    """商品分類"""
    __tablename__ = 'tb_goods_category'

    id = Column(Integer, primary_key=True, doc='商品分類ID')
    create_time = Column(DateTime, default=datetime.now, doc='創建時間')
    update_time = Column(DateTime, default=datetime.now, onupdate=datetime.now, doc='更新時間')
    name = Column(String(10), doc='名稱')
    parent_id = Column(Integer, default=None, doc='父類别')

    sku = relationship('SKU', back_populates='category')