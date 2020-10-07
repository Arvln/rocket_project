from fastapi import FastAPI ,Depends
from sqlalchemy.orm import Session
from fastapi.responses import JSONResponse
from datetime import date

from rocket_admin.fastapi_rest.statistical import crud, models
from rocket_admin.fastapi_rest.statistical.databases import SessionLocal ,engine


models.Base.metadata.create_all(bind=engine)

app = FastAPI()
now_date = str(date.today())

#Dependency
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

#用戶總數統計
@app.get('/api/users/total_count/')
def total_user_count(db: Session = Depends(get_db)):
    count = crud.get_user_count(db)
    #返回自定義Response
    return JSONResponse(status_code=200, content={'date':now_date, 'count':count})

#日增用戶數量統計
@app.get('/api/users/daily_increment/')
def user_daily_grouth(db:Session = Depends(get_db)):
    count = crud.get_daily_grouth(db)
    return JSONResponse(status_code=200, content={'date':now_date, 'count':count})

#日活用戶數量統計
@app.get('/api/users/daily_active/')
def user_daily_active(db:Session = Depends(get_db)):
    count = crud.get_daily_active(db)
    return JSONResponse(status_code=200, content={'date':now_date, 'count':count})

#當天下單用戶數量統計
@app.get('/api/users/daily_order/')
def user_daily_order(db:Session = Depends(get_db)):
    count = crud.get_daily_order(db)
    return JSONResponse(status_code=200, content={'date':now_date, 'count':count})

#月增用戶數量統計
@app.get('/api/users/month_increment/')
def user_month_grouth(db:Session = Depends(get_db)):
    date_list = crud.get_month_grouth(db)
    return JSONResponse(status_code=200, content=date_list)

#月活用戶數量統計
@app.get('/api/users/month_active/')
def user_month_active(db:Session = Depends(get_db)):
    date_list = crud.get_month_active(db)
    return JSONResponse(status_code=200, content=date_list)

#當天訪問分類資訊的訪問量
@app.get('/api/users/categories/daily_views/')
def categories_daily_visit(db:Session = Depends(get_db)):
    categories = crud.get_categories_daily_vist(db)
    categories_list = []
    for category in categories:
        categories_dict = {
            'category_id':category.category_id ,
            'count':category.count ,
        }
        categories_list.append(categories_dict)
    return JSONResponse(status_code=200, content=categories_list)

#獲取用戶數據
@app.get('/api/users/')
def get_user(db:Session = Depends(get_db)):
    users = crud.get_users(db)
    lists = []
    for user in users:
        user_dict = {
            'id':user.id ,
            'username':user.username ,
            'mobile':user.mobile ,
            'email':user.email
        }
        lists.append(user_dict)
    return JSONResponse(status_code=200, content=lists)


if __name__ == '__main__':
    import uvicorn
    uvicorn.run(app, host='127.0.0.1', port=8000)