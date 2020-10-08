from sqlalchemy.orm import Session ,load_only

from rocket_admin.fastapi_rest.orders import models ,schemas


def get_total_orders_list(db:Session):
    return db.query(models.OrderInfo).options(load_only(models.OrderInfo.order_id, models.OrderInfo.create_time)).all()

def get_order(pk:int, db:Session):
    return db.query(models.OrderInfo).get(pk)

def update_order(pk:int, status:schemas.OrderStatusRequestBody, db:Session):
    db.query(models.OrderInfo).filter(models.OrderInfo.order_id == pk).update(status.dict())
    return db.query(models.OrderInfo).get(pk)