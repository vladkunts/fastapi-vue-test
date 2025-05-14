from typing import Optional
from sqlmodel import Field, SQLModel, Relationship
from sqlalchemy import Column, String
from datetime import datetime

class Users(SQLModel, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    username: str = Field(sa_column=Column("username", String, unique=True, nullable=False))
    password: str
    name: str

class LoginLog(SQLModel, table=True):
    id: Optional[int] = Field(default=None, primary_key=True)
    user_id: int
    login_time: datetime = Field(default_factory=datetime.utcnow)
    user_agent: str