from sqlalchemy import BigInteger, Boolean, Column, DateTime, Integer, String, JSON
from sqlalchemy.orm import declarative_base
from datetime import datetime

Base = declarative_base()


class User(Base):
    __tablename__ = "users"

    user_id = Column(BigInteger, primary_key=True)
    filters = Column(JSON, default=list)
    is_admin = Column(Boolean, default=False)
    created_at = Column(DateTime, default=datetime.utcnow)


class Event(Base):
    __tablename__ = "events"

    id = Column(Integer, primary_key=True, autoincrement=False)  # usage of external ID
    title = Column(String(255))
    begin_ts = Column(DateTime)
    end_ts = Column(DateTime)
    location = Column(String(50))
    seats = Column(Integer)
    last_seen = Column(DateTime, default=datetime.utcnow)


class Course(Base):
    __tablename__ = "courses"

    title = Column(String(255), primary_key=True)
