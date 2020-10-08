from sqlalchemy import Column, Integer, String, DateTime, Boolean, Text, ForeignKey, DECIMAL
from sqlalchemy.orm import relationship
from datetime import datetime

from .databases import Base


#模型類和數據庫表映射
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
    category_id = Column(Integer, doc='商品分類ID')
    goods_id = Column(Integer, doc='商品ID')

    goods = relationship('OrderGoods', back_populates='sku')

class User(Base):
    """用戶基本資訊表"""
    __tablename__ = 'tb_user'

    id = Column(Integer, primary_key=True, doc='用戶ID')
    username = Column(String(150), doc='用戶名')

    order = relationship('OrderInfo', back_populates='user')

class OrderInfo(Base):
    """訂單資訊表"""
    __tablename__ = 'tb_order_info'

    create_time = Column(DateTime, default=datetime.now, doc='創建訂單時間')
    update_time = Column(DateTime, default=datetime.now, onupdate=datetime.now, doc='更新訂單時間')
    order_id = Column(String(64), primary_key=True, doc='訂單號碼')
    total_count = Column(Integer, default=1, doc='商品總數')
    total_amount = Column(DECIMAL(10,2), doc='商品總金額')
    freight = Column(DECIMAL(10,2), doc='運費')
    pay_method = Column(Integer, default=1, doc='支付方式')
    status = Column(Integer, default=1, doc='訂單狀態')
    user_id = Column(Integer, ForeignKey('tb_user.id'), doc='用戶ID')

    skus = relationship('OrderGoods', back_populates='order')
    user = relationship('User', back_populates='order')

class OrderGoods(Base):
    """訂單商品"""
    __tablename__ = 'tb_order_goods'

    id = Column(Integer, primary_key=True, doc='訂單商品ID')
    create_time = Column(DateTime, default=datetime.now, doc='創建時間')
    update_time = Column(DateTime, default=datetime.now, onupdate=datetime.now, doc='更新時間')
    count = Column(Integer, default=1, doc='數量')
    price = Column(DECIMAL(10,2), doc='單價')
    comment = Column(Text, default="", doc='評價資訊')
    score = Column(Integer, default=5, doc='滿意度評分')
    is_anonymous = Column(Boolean, default=False, doc='是否匿名評價')
    is_commented = Column(Boolean, default=False, doc='是否評價')
    order_id = Column(String(64), ForeignKey('tb_order_info.order_id'), doc='訂單ID')
    sku_id = Column(Integer, ForeignKey('tb_sku.id'), doc='SKU商品ID')

    sku = relationship('SKU', back_populates='goods')
    order = relationship('OrderInfo', back_populates='skus')