#!/bin/bash

sed -i "s@127.0.0.1@$DB_HOST@g" /usr/local/apioak/conf/apioak.yaml
sed -i "s@3306@$DB_PORT@g" /usr/local/apioak/conf/apioak.yaml
sed -i "s@apioak@$DB_NAME@g" /usr/local/apioak/conf/apioak.yaml
sed -i "s@root@$DB_USER@g" /usr/local/apioak/conf/apioak.yaml
sed -i "s@123000@$DB_PASSWORD@g" /usr/local/apioak/conf/apioak.yaml



/usr/bin/apioak start