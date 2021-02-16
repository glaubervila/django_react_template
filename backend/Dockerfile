

FROM python:3.9

ENV APP_PATH=/app

RUN mkdir $APP_PATH

WORKDIR $APP_PATH

RUN apt-get update && apt-get install -y  \
    python-dev \
    libaio-dev \
    build-essential \
    vim \
    && rm -rf /var/lib/apt/lists/*


ADD requirements.txt $APP_PATH

RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt


COPY . $APP_PATH

ENTRYPOINT $APP_PATH/entrypoint.sh