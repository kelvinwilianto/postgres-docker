#!/bin/bash
# PostgreSQL Backup Script

BACKUP_DIR="./backups"
DATE=$(date +%Y%m%d_%H%M%S)
CONTAINER="postgres_db"

# Create backup directory if not exists
mkdir -p $BACKUP_DIR

# Get database credentials from .env
source .env

# Backup all databases
docker exec $CONTAINER pg_dumpall -U ${POSTGRES_USER} > $BACKUP_DIR/backup_all_${DATE}.sql

# Keep only last 7 days of backups
find $BACKUP_DIR -name "backup_*.sql" -mtime +7 -delete

echo "Backup completed: $BACKUP_DIR/backup_all_${DATE}.sql"
