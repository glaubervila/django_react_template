#!/bin/sh

cd $APP_PATH

# Se nao tiver o manage.py e a primeira vez que o container e executado, apenas abre o terminal.
if [ -e manage.py ]
then
    echo "Running Migrate to apply changes in database"
    python manage.py migrate

    echo "Running Collect Statics"
    python manage.py collectstatic --clear --noinput --verbosity 0

    echo "Starting Gunicorn"
    gunicorn --bind 0.0.0.0:8001 \
        api.wsgi:application \
        --reload --workers=3 --threads=3

else
    /bin/bash
fi
