from sqlalchemy import Column, Integer, String, DateTime, Boolean, DECIMAL
from sqlalchemy.orm import relationship
from datetime import datetime

from .databases import Base


#模型類和數據庫表映射
class User(Base):
    """用戶基本資訊表"""
    #跟數據庫中表名作映射，須跟數據庫表名一致否則查詢為空
    __tablename__ = 'tb_user'

    class EMAIL_ACTIVE:
        DISABLE = 0
        ENABLE = 1

    id = Column(Integer, primary_key=True, doc='用戶ID')
    password = Column(String(128), doc='密碼')
    last_login = Column(DateTime, default=None, doc='最後登錄時間')
    is_superuser = Column(Boolean, default=False,doc='是否是超級管理員')
    username = Column(String(150), doc='用戶名')
    first_name = Column(String(150), doc='名')
    last_name = Column(String(150), doc='姓')
    email = Column(String(254), doc='Enmail')
    is_staff = Column(Boolean, default=False, doc='是否是管理員')
    is_active = Column(Boolean, default=True, doc='是否啟用')
    date_joined = Column(DateTime, default=datetime.now, doc='創建時間')
    mobile = Column(String(10), doc='手機號碼')
    email_active = Column(Integer, default=0, doc='Email驗證狀態')
    default_address_id = Column(Integer, default=None, doc='默認地址')

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

class GoodsVisit(Base):
    """統計分類商品數量表"""
    __tablename__ = 'tb_goods_visit'

    id = Column(Integer, primary_key=True, doc='商品類別統計編號')
    create_time = Column(DateTime, default=datetime.now, doc='創建類別統計時間')
    update_time = Column(DateTime, default=datetime.now, onupdate=datetime.now, doc='更新類別統計時間')
    count = Column(Integer, doc='訪問量')
    date = Column(DateTime, default=datetime.now, doc='統計日期')
    category_id = Column(Integer, doc='商品分類ID')