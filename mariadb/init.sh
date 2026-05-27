#!/bin/bash
set -e

# Replace environment variables in SQL template
envsubst < /docker-entrypoint-initdb.d/init.sql.template > /tmp/init.sql

# Execute the SQL file
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" < /tmp/init.sql
