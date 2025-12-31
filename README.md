# PostgreSQL Docker Setup

A simple Docker-based PostgreSQL database setup.

## Features

- PostgreSQL 16 (Alpine)
- Persistent data storage with Docker volumes
- Health checks for PostgreSQL
- Initialization scripts support
- Environment-based configuration

## Prerequisites

- Docker
- Docker Compose

## Quick Start

1. **Copy the environment file:**

   ```bash
   cp .env.example .env
   ```

2. **Edit `.env` file with your desired credentials:**

   ```env
   POSTGRES_USER=your_username
   POSTGRES_PASSWORD=your_secure_password
   POSTGRES_DB=your_database_name
   ```

3. **Start the containers:**

   ```bash
   docker-compose up -d
   ```

4. **Check container status:**

   ```bash
   docker-compose ps
   ```

## Accessing the Database

### PostgreSQL Connection

- **Host:** localhost
- **Port:** 5432 (configurable via `POSTGRES_PORT` in `.env`)
- **Database:** mydb (configurable via `POSTGRES_DB`)
- **Username:** postgres (configurable via `POSTGRES_USER`)
- **Password:** postgres (configurable via `POSTGRES_PASSWORD`)

**Connection string example:**

```
postgresql://postgres:postgres@localhost:5432/mydb
```

## Initialization Scripts

Place your SQL initialization scripts in the `init-scripts/` directory. They will be executed in alphabetical order when the PostgreSQL container is created for the first time.

Example scripts are provided in `init-scripts/01-init.sql`.

## Docker Commands

### Start services

```bash
docker-compose up -d
```

### Stop services

```bash
docker-compose down
```

### Stop and remove volumes (⚠️ this will delete all data)

```bash
docker-compose down -v
```

### View logs

```bash
docker-compose logs -f postgres
```

### Restart services

```bash
docker-compose restart
```

### Access PostgreSQL CLI

```bash
docker exec -it postgres_db psql -U postgres -d mydb
```

## Backup and Restore

### Backup database

```bash
docker exec postgres_db pg_dump -U postgres mydb > backup.sql
```

### Restore database

```bash
docker exec -i postgres_db psql -U postgres mydb < backup.sql
```

## Configuration

All configuration is managed through environment variables in the `.env` file:

| Variable | Description | Default |
|----------|-------------|---------||
| `POSTGRES_USER` | PostgreSQL username | postgres |
| `POSTGRES_PASSWORD` | PostgreSQL password | postgres |
| `POSTGRES_DB` | Database name | mydb |
| `POSTGRES_PORT` | PostgreSQL port | 5432 |

## Troubleshooting

### Container won't start

Check logs: `docker-compose logs postgres`

### Can't connect to database

1. Ensure container is running: `docker-compose ps`
2. Check health status: `docker inspect postgres_db`
3. Verify environment variables in `.env`

### Reset everything

```bash
docker-compose down -v
docker-compose up -d
```

## Security Notes

- Change default passwords in `.env` before deploying
- Never commit `.env` file to version control
- Use strong passwords in production
- Consider using Docker secrets for sensitive data in production
