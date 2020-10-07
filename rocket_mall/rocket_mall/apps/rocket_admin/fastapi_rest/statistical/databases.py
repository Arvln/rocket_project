from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base


#數據庫初始配置
SQLALCHEMY_DATABASE_URL = 'mysql://rocket_it:123456@172.18.0.2:3306/rocket_mall'
engine = create_engine(SQLALCHEMY_DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()