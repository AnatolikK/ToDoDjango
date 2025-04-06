#!/bin/sh

# Ожидание, пока база данных станет доступной
while ! nc -z db 5432; do
  echo "Waiting for database..."
  sleep 1
done

# Выполняем миграции
echo "Running migrations..."
python /TodoProject/manage.py migrate

# Запускаем приложение
exec "$@"