from datetime import datetime, timedelta, timezone
from typing import Annotated, Union
from pydantic import BaseModel
import hashlib
import jwt

from fastapi import FastAPI, Depends, HTTPException, Request, status
from fastapi.middleware.cors import CORSMiddleware
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from sqlmodel import Session, select
from src.models import Users, LoginLog
from src.db import get_session


SECRET_KEY = "9dea895349e12bd5d5b2d0df6a1211319b02eda0a5728b8dedabc52cda1594eb"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 30

app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:8080",
        "http://localhost:5555"
    ],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class Token(BaseModel):
    access_token: str
    token_type: str

class TokenData(BaseModel):
    username: Union[str, None] = None

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

# check if the user exists and the password is correct
def authenticate_user(username: str, password: str, session: Session):
    user = session.exec(
        select(Users).where(Users.username == username)
    ).first()
    hashed_password = hashlib.sha256(password.encode()).hexdigest()
    if not user:
        return False
    if hashed_password != user.password:
        return False
    return user

# check if the user is logged in
async def get_current_user(
    token: Annotated[str, Depends(oauth2_scheme)],
    session: Session = Depends(get_session)
):
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        username = payload.get("sub")
        if username is None:
            raise credentials_exception
    except jwt.InvalidTokenError:
        raise credentials_exception
    user = session.exec(
        select(Users).where(Users.username == username)
    ).first()
    if user is None:
        raise credentials_exception
    return user

def create_access_token(data: dict, expires_delta: timedelta | None = None):
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.now(timezone.utc) + expires_delta
    else:
        expire = datetime.now(timezone.utc) + timedelta(minutes=15)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt

def add_login_log(user_id: int, user_agent: str, session: Session):
    login_log = LoginLog(user_id=user_id, user_agent=user_agent)
    session.add(login_log)
    session.commit()


# ROUTES

# Health check endpoint
@app.get("/health")
async def health():
    return {"status": "healthy"}

# Login endpoint
@app.post("/token")
async def get_token_after_login(
    form_data: Annotated[OAuth2PasswordRequestForm, Depends()],
    request: Request,
    session: Session = Depends(get_session)
) -> Token:
    user = authenticate_user(form_data.username, form_data.password, session)
    if not user:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Incorrect username or password",
            headers={"WWW-Authenticate": "Bearer"},
        )
    
    user_agent = request.headers.get("user-agent")
    add_login_log(user_id=user.id, user_agent=user_agent, session=session)
    
    access_token_expires = timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    access_token = create_access_token(
        data={"sub": user.username}, expires_delta=access_token_expires
    )
    return Token(access_token=access_token, token_type="bearer")

# Get all login logs
@app.get("/loginlogs")
async def get_login_logs(
    current_user: Annotated[Users, Depends(get_current_user)],
    session: Session = Depends(get_session)
):
    login_logs = session.exec(
        select(LoginLog, Users)
        .where(LoginLog.user_id == Users.id)
        .order_by(LoginLog.login_time.desc())
    ).all()
    result = []
    for log in login_logs:
        result.append({
            "username": log[1].username,
            "name": log[1].name,
            "login_time": log[0].login_time.astimezone(timezone(timedelta(hours=3))).strftime("%Y-%m-%d %H:%M:%S"),
            "user_agent": log[0].user_agent
        })
    return result