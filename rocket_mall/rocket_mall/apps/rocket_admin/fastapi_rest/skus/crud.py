from sqlalchemy.orm import Session ,load_only

from rocket_admin.fastapi_rest.skus import models ,schemas


def get_total_skus(db:Session):
    return db.query(models.SKU).all()

def get_goods_info(db:Session):
    return db.query(models.Goods).options(load_only(models.Goods.id, models.Goods.name)).all()

def get_total_specs(pk:int, db:Session):
    return db.query(models.GoodsSpecification).get(pk)

def create_sku(sku:schemas.SKURequestBody, db:Session):
    new_sku = models.SKU(**sku.dict())
    db.add(new_sku)
    db.commit()
    db.refresh(new_sku)
    return new_sku

def get_sku_by_pk(pk:int, db:Session):
    return db.query(models.SKU).get(pk)

def update_sku(pk:int, sku:schemas.SKURequestBody, db:Session):
    db.query(models.SKU).filter(models.SKU.id == pk).update(sku.dict())
    db.commit()
    return db.query(models.SKU).get(pk)

def remove_sku(pk:int, db:Session):
    db.delete(get_sku_by_pk(pk=pk, db=db))
    db.commit()