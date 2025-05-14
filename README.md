# FastAPI + Vue 3 — Test Project

A simple full-stack test application with:

- Frontend: Vue 3 (Vite)
- Backend: FastAPI + SQLModel
- Database: PostgreSQL
- Auth: JWT-based login
- Extra: All logins are recorded in the database

## How to run

### 1. Clone the repository

```bash
git clone git@github.com:vladkunts/fastapi-vue-test.git
cd fastapi-vue-test
```

### 2. Run the project with Docker

```bash
docker compose up --build
```

The backend will be available at: [http://localhost:5555](http://localhost:5555)  
The frontend will be available at: [http://localhost:8080](http://localhost:8080)

### 3. Default users

The database includes two predefined users:

| Username | Password |
|----------|----------|
| `admin`  | `admin` |
| `user`   | `user` |

## Project structure

```
services/
├── backend/      # FastAPI app with database logic and auth
├── frontend/     # Vue 3 app with login UI and protected dashboard
```

## Notes

- All successful logins are stored in the `loginlog` table.
- Redirects to `/dashboard` after login; unauthorized users are redirected to `/`.

## License

MIT — feel free to use, modify and test.
