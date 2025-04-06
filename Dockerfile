# Используем легковесный образ Python на базе Alpine
FROM python:3.9-alpine

# Устанавливаем необходимые зависимости
RUN apk add --no-cache postgresql-dev gcc musl-dev

# Устанавливаем рабочую директорию
WORKDIR /TodoProject

# Копируем файлы проекта
COPY TodoProject/ .

# Устанавливаем зависимости
RUN pip install --no-cache-dir -r requirements.txt

# Копируем скрипт entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Очищаем кеш
RUN rm -rf /var/cache/apk/*

# Запускаем приложение с помощью entrypoint
ENTRYPOINT ["/entrypoint.sh"]
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "TodoProject.wsgi:application"]