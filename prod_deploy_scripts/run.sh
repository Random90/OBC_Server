#!/bin/bash
USER=`whoami`

cd /home/${USER}/prod/OBC_Server || exit 1

echo "Activating virtual env"
source venv/bin/activate

export SECRET_KEY=`cat .django_secret_key`

echo "Starting uwsgi as deamon"
uwsgi --chdir=/home/${USER}/prod/OBC_Server \
    --module=obc_server.wsgi:application \
    --env DJANGO_SETTINGS_MODULE=obc_server.settings.production \
    --master --pidfile=/tmp/obc_server.pid \
    --socket=127.0.0.1:42137 \
    --processes=5 \
    --uid=1000 \
    --harakiri=20 \
    --max-requests=5000 \
    --vacuum \
    --home=/home/${USER}/prod/OBC_Server/venv \
    --logto=/var/log/obc_server.log