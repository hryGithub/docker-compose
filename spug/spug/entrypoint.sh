#!/bin/sh
# Copyright: (c) OpenSpug Organization. https://github.com/openspug/spug
# Copyright: (c) <spug.dev@gmail.com>
# Released under the MIT License.

set -e

# init spug
if [ ! -f /spug/spug_api/db.sqlite3 ]; then
    cd /spug/spug_api
    python manage.py initdb
    python manage.py useradd -u admin -p spug.dev -s -n 管理员
fi
sed -i "s@ALLOWED_HOSTS = ['127.0.0.1']@ALLOWED_HOSTS = ['*']@g" /spug/spug_api/spug/settings.py
sed -i "s@127.0.0.1@$REDIS_HOST@g" /spug/spug_api/spug/settings.py
sed -i "s@6379@$REDIS_PORT@g" /spug/spug_api/spug/settings.py

gunicorn -b 0.0.0.0:9001 -w 2 --threads 8 --access-logfile - spug.wsgi &
python manage.py runmonitor &
python manage.py runscheduler &
python manage.py runworker ssh_exec &
daphne -p 9002 spug.asgi:application