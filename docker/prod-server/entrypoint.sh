#! /bin/sh

echo "Running etesync test server ${ETESYNC_VERSION}"

cd /app
mkdir -p ./data/static ./data/media
python manage.py migrate
python manage.py collectstatic --noinput

uvicorn etebase_server.asgi:application --host 0.0.0.0 --port 80
