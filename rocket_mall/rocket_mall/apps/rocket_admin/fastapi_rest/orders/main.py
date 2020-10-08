from fastapi import FastAPI ,Depends
from sqlalchemy.orm import Session
from fastapi.responses import JSONResponse
from typing import List

from rocket_admin.fastapi_rest.orders import models ,schemas ,crud
from rocket_admin.fastapi_rest.orders.databases import SessionLocal ,engine


models.Base.metadata.create_all(bind=engine)

app = FastAPI()

#Dependency
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

#獲取訂單列表數據
@app.get('/api/orders/', response_model=List[schemas.OrderInfoList])
def get_orders_list(db:Session = Depends(get_db)):
    orders = crud.get_total_orders_list(db)
    return orders
#獲取指定訂單表數據(pk=order_id)
@app.get('/api/orders/{pk}/', response_model=schemas.OrderInfo)
def get_order(pk:int, db:Session = Depends(get_db)):
    order = crud.get_order(pk=pk, db=db)
    return order
#更新訂單表數據
@app.put('/api/orders/{pk}/status/', response_model=schemas.OrderStatus)
def update_order(pk:int, status:schemas.OrderStatusRequestBody, db:Session = Depends(get_db)):
    order = crud.update_order(pk=pk, status=status, db=db)
    return order

if __name__ == '__main__':
    import uvicorn
    uvicorn.run(app, host='127.0.0.1', port=8000)