from fastapi import FastAPI ,Depends
from sqlalchemy.orm import Session
from fastapi.responses import JSONResponse

from rocket_admin.fastapi_rest.specs import models ,schemas ,crud
from rocket_admin.fastapi_rest.specs.databases import SessionLocal ,engine


models.Base.metadata.create_all(bind=engine)

app = FastAPI()

#Dependency
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

#獲取SPU規格表數據
@app.get('/api/goods/specs/')
def get_goods_specs(db:Session = Depends(get_db)):
    specs = crud.get_specs(db)
    lists = []
    for spec in specs:
        spec_dict = {
            'id':spec.id ,
            'name':spec.name ,
            'good_id':spec.goods.id ,
            'good':spec.goods.name ,
        }
        lists.append(spec_dict)
    return JSONResponse(status_code=200, content=lists)
#新增SPU規格表數據
@app.post('/api/goods/specs/')
def create_goods_spec(spec:schemas.GoodsSpecRequestBody, db:Session = Depends(get_db)):
    good_spec = crud.create_spec(db=db, spec=spec)
    good_spec_dict = {
        'id':good_spec.id ,
        'name':good_spec.name ,
        'good_id':good_spec.goods.id ,
        'good':good_spec.goods.name ,
    }
    return JSONResponse(status_code=200, content=good_spec_dict)
#獲取指定SPU規格表數據
@app.get('/api/goods/specs/{pk}/')
def get_goods_spec(pk:int, db:Session = Depends(get_db)):
    good_spec = crud.get_spec(db=db, pk=pk)
    good_spec_dict = {
        'id': good_spec.id,
        'name': good_spec.name,
        'good_id': good_spec.goods.id,
        'good': good_spec.goods.name,
    }
    return JSONResponse(status_code=200, content=good_spec_dict)
#更新SPU規格表數據
@app.put('/api/goods/specs/{pk}/')
def update_goods_spec(pk:int, spec:schemas.GoodsSpecRequestBody, db:Session = Depends(get_db)):
    good_spec = crud.update_spec(pk=pk, spec=spec, db=db)
    good_spec_dict = {
        'id': good_spec.id,
        'name': good_spec.name,
        'good_id': good_spec.goods.id,
        'good': good_spec.goods.name,
    }
    return JSONResponse(status_code=200, content=good_spec_dict)

#刪除SPU規格表數據
@app.delete('/api/goods/specs/{pk}/')
def remove_goods_spec(pk:int, db:Session = Depends(get_db)):
    crud.remove_spec(pk=pk, db=db)
    return JSONResponse(status_code=200)

if __name__ == '__main__':
    import uvicorn
    uvicorn.run(app, host='127.0.0.1', port=8000)