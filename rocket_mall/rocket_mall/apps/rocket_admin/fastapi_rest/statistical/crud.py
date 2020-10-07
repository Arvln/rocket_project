from sqlalchemy.orm import Session
from datetime import date ,timedelta

from .models import User ,OrderInfo ,GoodsVisit


def get_user_count(db:Session):
    return len(db.query(User).all())

def get_daily_grouth(db:Session):
    return db.query(User).filter(User.date_joined >= date.today()).count()

def get_daily_active(db:Session):
    return db.query(User).filter(User.last_login >= date.today()).count()

def get_daily_order(db:Session):
    return db.query(OrderInfo).filter(OrderInfo.create_time >= date.today()).count()

def get_month_grouth(db:Session):
    now_date = date.today()
    first_date = now_date - timedelta(29)
    date_list = []
    for i in range(30):
        begin_date = first_date + timedelta(days=i)
        next_date = begin_date + timedelta(days=1)
        date_dict = {
            'date':str(begin_date) ,
            'count':db.query(User).filter(
                User.date_joined >= begin_date,
                User.date_joined <= next_date
            ).count()
        }
        date_list.append(date_dict)
    return date_list

def get_month_active(db:Session):
    now_date = date.today()
    first_date = now_date - timedelta(29)
    date_list = []
    for i in range(30):
        begin_date = first_date + timedelta(days=i)
        next_date = begin_date + timedelta(days=1)
        date_dict = {
            'date': str(begin_date),
            'count': db.query(User).filter(
                User.last_login >= begin_date,
                User.last_login <= next_date
            ).count()
        }
        date_list.append(date_dict)
    return date_list

def get_categories_daily_vist(db:Session):
    now_date = date.today()
    return db.query(GoodsVisit).filter(GoodsVisit.date == now_date).all()

def get_users(db:Session):
    return db.query(User).all()