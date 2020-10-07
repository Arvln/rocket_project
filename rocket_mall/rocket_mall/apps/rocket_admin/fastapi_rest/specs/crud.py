from sqlalchemy.orm import Session

from rocket_admin.fastapi_rest.specs import models ,schemas


def get_specs(db:Session):
    return db.query(models.GoodsSpecification).all()

def create_spec(spec:schemas.GoodsSpecBase, db:Session):
    good_spec = models.GoodsSpecification(name=spec.name, goods_id=spec.goods_id)
    db.add(good_spec)
    db.commit()
    db.refresh(good_spec)
    return good_spec

def get_spec(pk:int, db:Session):
    good_spec = db.query(models.GoodsSpecification).get(pk)
    return good_spec

def update_spec(pk:int, spec:schemas.GoodsSpecBase, db:Session):
    good_spec = get_spec(pk=pk, db=db)
    good_spec.name = spec.name
    good_spec.goods_id = spec.goods_id
    db.add(good_spec)
    db.commit()
    db.refresh(good_spec)
    return good_spec

def remove_spec(pk:int, db:Session):
    good_spec = get_spec(pk=pk, db=db)
    db.delete(good_spec)
    db.commit()