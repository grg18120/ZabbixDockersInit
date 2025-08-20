#!/bin/bash 

# Variables
while getopts c:d:r:u:p:v:n: flag
do
    case "${flag}" in
      c) container=${OPTARG};;
		  d) mysql_db_name=${OPTARG};;
		  r) my_sql_root_pass=${OPTARG};;
		  u) mysql_user=${OPTARG};;
		  p) mysql_user_pass=${OPTARG};;
		  v) containers_volumes=${OPTARG};;
		  n) containers_network=${OPTARG};;
    esac
done


source "~/test/ZabbixDockersInit/lib/dockers_utils.sh"
# source "$PROJECT_PATH/lib/dockers_utils.sh"
delete_container "$container"


# Run Docker
docker run --name $container -t \
  -v $containers_volumes/$container/mysqlfiles:/var/lib/mysql \
  -e MYSQL_DATABASE="$mysql_db_name" \
  -e MYSQL_ROOT_PASSWORD="$my_sql_root_pass" \
  -e MYSQL_USER="$mysql_user" \
  -e MYSQL_PASSWORD="$mysql_user_pass" \
  --network=$containers_network \
  --restart unless-stopped \
  -d mysql:8.0-oracle \
  --character-set-server=utf8mb4 \
  --collation-server=utf8mb4_unicode_ci \
  --default-authentication-plugin=caching_sha2_password