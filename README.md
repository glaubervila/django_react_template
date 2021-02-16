# django_react_template

Example of a development environment with Django + React + Mysql + Nginx + Docker.

**TODO** Escrever uma descrição completa dos componentes e da estrutura. 

## Installation

Clone the repository

```shell 

git clone https://github.com/glaubervila/django_react_template.git

``` 

Create the docker-compose file based on the template. this file describes the entire infrastructure of the project. contains different images for each service. depending on the environment the changes will be made in this file, for development use the docker-compose_development.yml for production you will need to create your own compose, using the builded images. but as a starting point you can use the example docker-compose_production.yml

```shell 

cp docker-compose_development.yml docker-compose.yml
```

Create the .env file with the environment variables.

``` shell

cp env_template .env
```

Let's start by surveying the environment through the database. but before starting the service edit the .env file and fill in the Mysql variables as you prefer.

The variables to be changed are:

``` shell

# Mysql

...
MYSQL_DATABASE=your_database_name
MYSQL_USER=your_user
MYSQL_PASSWORD=your_password
...

```

After filling in the user and password variables.

Start the database for the first time.

``` shell
docker-compose up database
```

this command will start mysql and create the database and the user, the way it is configured we are not using root user. but you can change that if you want.

After seeing the message ` ... ready for connections. Version: '8.0.23' ... ` you can turn off the container by pressing *CTRL + C*.

Now let's turn on the backend.

``` shell
docker-compose up backend
```

This command will turn on the backend container and start Django, in this step the migrations will be applied to the database. it is not necessary to start the database first because it is dependent on the backend and will be turned on automatically.
After the message `[INFO] Starting gunicorn 20.0.4` the backend is on. let's leave it on and open a new terminal to execute some commands.

In a new terminal, with the backend still on.
use this command to discover the name of the container.

inside the application root directory

``` shell
docker-compose ps
```

the exit is something similar to this

``` shell
~/django_react_template (main) $ docker-compose ps
              Name                            Command               State          Ports       
-----------------------------------------------------------------------------------------------
django_react_template_backend_1    /bin/sh -c $APP_PATH/entry ...   Up                         
django_react_template_database_1   docker-entrypoint.sh mysqld      Up      3306/tcp, 33060/tcp
```

this is the name of the container with the backend `django_react_template_backend_1` . The name may vary depending on the name you used for the project folder.

Create a Secret Key for Django

``` shell
docker exec -it django_react_template_backend_1 python -c 'from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())'
```

This command generates a secret key for Django.
Copy the command output, edit the .env file and paste the key in the *DJANGO_SECRET_KEY* environment variable. 

The generated key looks like this `h+r5wq+&-vlz35i@ef3i066rf7mj_64p7l3f+^!31(m4+ir#fw` and the .env file looks like this 

``` shell
# Django Settings
DJANGO_SECRET_KEY="h+r5wq+&-vlz35i@ef3i066rf7mj_64p7l3f+^!31(m4+ir#fw"
...
```

Create a super user for Django.

``` shell
docker exec -it django_react_template_backend_1 python manage.py createsuperuser
```

After creating the Django administrator user, turn off the backend.

go back to the terminal where it is and press CTRL + C or execute `docker-compose stop`

Start all services

``` shell
docker-compose up
```

Or

``` shell
docker-compose up -d
```

to run in the background and release the terminal.

Test the environment

Open the Browser and access the environment at the following URLs

* http://localhost/ - React App for frontend.

* http://localhost/admin/ - Django administration use the superuser to login.

* http://localhost/api/ - Django REST browsable API.
