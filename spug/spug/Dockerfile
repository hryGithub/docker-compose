FROM python:3.6.10-alpine3.11

RUN echo -e "http://mirrors.aliyun.com/alpine/v3.11/main\nhttp://mirrors.aliyun.com/alpine/v3.11/community" > /etc/apk/repositories
RUN apk add --no-cache git python3-dev openldap-dev openssl-dev gcc
RUN git clone https://github.com/openspug/spug.git --depth=1 /spug && cd /spug && git pull
RUN pip config set global.index-url https://mirrors.aliyun.com/pypi/simple/  && pip install --upgrade pip && pip install --no-cache-dir -r /spug/spug_api/requirements.txt \
    && pip install --no-cache-dir gunicorn \
    && rm -rf ~/.cache/pip


ENV REDIS_HOST=127.0.0.1 \
    REDIS_PORT=6379 \
    REDIS_PASSWORD= 


ADD entrypoint.sh /entrypoint.sh
EXPOSE 9001 9002
ENTRYPOINT ["sh", "/entrypoint.sh"]
