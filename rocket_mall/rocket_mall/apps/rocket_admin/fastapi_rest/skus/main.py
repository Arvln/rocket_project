from fastapi import FastAPI ,Depends
from sqlalchemy.orm import Session
from fastapi.responses import JSONResponse
from typing import List

from rocket_admin.fastapi_rest.skus import models ,schemas ,crud
from rocket_admin.fastapi_rest.skus.databases import SessionLocal ,engine


models.Base.metadata.create_all(bind=engine)

app = FastAPI()

#Dependency
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

#獲取SKU表數據
@app.get('/api/skus/', response_model=List[schemas.SKU]) #多條返回用List[]
def get_skus(db:Session = Depends(get_db)):
    skus = crud.get_total_skus(db)
    return skus
#獲取三級分類數據

#獲取SPU表名稱數據
@app.get('/api/goods/simple/', response_model=List[schemas.Goods])
def get_goods(db:Session = Depends(get_db)):
    goods = crud.get_goods_info(db)
    return goods
#獲取SPU表商品規格訊息
@app.get('/api/goods/{pk}/specs/', response_model=schemas.GoodsSpecification) #單條返回不用List[]，否則報錯
def get_goods_specs(pk:int, db:Session = Depends(get_db)):
    goods_specs = crud.get_total_specs(pk=pk, db=db)
    return goods_specs
#新增SKU表數據
@app.post('/api/skus/', response_model=schemas.SKU)
def create_skus(sku:schemas.SKURequestBody, db:Session = Depends(get_db)):
    new_sku = crud.create_sku(sku=sku, db=db)
    return new_sku
#獲取指定SKU表數據
@app.get('/api/skus/{pk}/', response_model=schemas.SKU)
def get_sku(pk:int, db:Session = Depends(get_db)):
    target_sku = crud.get_sku_by_pk(pk=pk, db=db)
    return target_sku
#更新指定SKU表數據
@app.put('/api/skus/{pk}/', response_model=schemas.SKU)
def update_skus(pk:int, sku:schemas.SKURequestBody, db:Session = Depends(get_db)):
    new_sku = crud.update_sku(pk=pk, sku=sku, db=db)
    return new_sku
#刪除SKU表數據
@app.delete('/api/skus/{pk}/')
def remove_skus(pk:int, db:Session = Depends(get_db)):
    crud.remove_sku(pk=pk, db=db)
    return JSONResponse(status_code=200)

if __name__ == '__main__':
    import uvicorn
    uvicorn.run(app, host='127.0.0.1', port=8000)