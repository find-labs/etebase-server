FROM python:3.9.0-alpine

ARG ETESYNC_VERSION

ENV PIP_DISABLE_PIP_VERSION_CHECK=1
ENV PIP_NO_CACHE_DIR=1

RUN mkdir /app
WORKDIR /app

# install packages and pip requirements first, in a single step,
COPY /requirements.in/base.txt /requirements.txt
RUN set -ex ;\
    apk add libpq postgresql-dev --virtual .build-deps coreutils gcc libc-dev libffi-dev make ;\
    pip install -U pip ;\
    pip install --no-cache-dir --progress-bar off -r /requirements.txt ;\
    rm -rf /root/.cache

COPY . /app

RUN set -ex ;\
    mkdir -p /etc/etebase-server ;\
    cp docker/prod-server/etebase-server.ini /etc/etebase-server ;\
    cp docker/prod-server/etebase-server.ini /app ;\
    sed -e '/ETEBASE_CREATE_USER_FUNC/ s/^#*/#/' -i /app/etebase_server/settings.py ;\
    chmod +x docker/prod-server/entrypoint.sh

ENV ETESYNC_VERSION=${ETESYNC_VERSION}

EXPOSE 80

ENTRYPOINT ["/app/docker/prod-server/entrypoint.sh"]
