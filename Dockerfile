from alpine:3.11.6

RUN apk add --no-cache python3-dev mariadb-connector-c-dev build-base linux-headers\
    && pip3 install --upgrade pip

WORKDIR /server
COPY . /server

RUN pip3 --no-cache-dir install -r requirements.txt

# the mariadb plugin directory seems to be misconfigured
# bei default. In order to work properly we manually adjust
# the path.
ENV MARIADB_PLUGIN_DIR /usr/lib/mariadb/plugin

#EXPOSE 5000
#CMD ["python3", "server.py"]

#run the command to start uWSGI
CMD ["uwsgi", "app.ini"]

