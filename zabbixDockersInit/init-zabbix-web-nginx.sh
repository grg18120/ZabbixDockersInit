#!/bin/bash

# Variables
while getopts x:c:z:m:d:r:u:p:w:n: flag
do
    case "${flag}" in
        x) project_path=${OPTARG};;
        c) container_zabbix_web_ngx=${OPTARG};;
        z) container_zabbix_server=${OPTARG};;
        m) container_zabbix_mysql_server=${OPTARG};;
        d) mysql_db_name=${OPTARG};;
        r) my_sql_root_pass=${OPTARG};;
        u) mysql_user=${OPTARG};;
        p) mysql_user_pass=${OPTARG};;
        w) http_port=${OPTARG};;
        n) containers_network=${OPTARG};;
    esac
done

# Run Docker
docker run --name $container_zabbix_web_ngx -t \
	-v $project_path/$container_zabbix_web_ngx/nginx-ssl:/etc/ssl/nginx \
	-e ZBX_SERVER_HOST=$container_zabbix_server \
	-e DB_SERVER_HOST=$container_zabbix_mysql_server \
	-e MYSQL_DATABASE=$mysql_db_name \
	-e MYSQL_USER=$mysql_user \
	-e MYSQL_PASSWORD=$mysql_user_pass \
	-e MYSQL_ROOT_PASSWORD=$my_sql_root_pass \
	-e PHP_TZ="Europe/Bucharest" \
	--network=$containers_network \
	-p $http_port:8443 \
	--restart unless-stopped \
	-d zabbix/zabbix-web-nginx-mysql:alpine-6.4-latest