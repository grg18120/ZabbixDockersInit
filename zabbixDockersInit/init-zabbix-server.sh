#!/bin/bash

# Variables
while getopts x:c:m:d:r:u:p:v:n: flag
do
    case "${flag}" in
        x) project_path=${OPTARG};;
        c) container_zabbix_server=${OPTARG};;
        m) container_zabbix_mysql_server=${OPTARG};;
        d) mysql_db_name=${OPTARG};;		  
		r) my_sql_root_pass=${OPTARG};;
        u) mysql_user=${OPTARG};;
        p) mysql_user_pass=${OPTARG};;
        v) containers_volumes=${OPTARG};;
        n) containers_network=${OPTARG};;    
    esac
done
		# j) zabbixJavaGatewayContName=${OPTARG};;
		# l) linkSnmpTraps=${OPTARG};;  



# Replace characters "%" with " " (!!!this command need to run this script with bash no sh)
# linkSnmpTraps="${linkSnmpTraps//%/ }"

#Run Docker
docker run --name "$container_zabbix_server" -t \
	-v "$project_path"/"$container_zabbix_server"/alertscripts:/usr/lib/zabbix/alertscripts \
	-v "$project_path"/"$container_zabbix_server"/externalscripts:/usr/lib/zabbix/externalscripts \
	-v "$project_path"/"$container_zabbix_server"/modules:/var/lib/zabbix/modules \
	-v "$project_path"/"$container_zabbix_server"/enc:/var/lib/zabbix/enc \
	-v "$project_path"/"$container_zabbix_server"/ssl_certs:/var/lib/zabbix/ssl/certs \
	-v "$project_path"/"$container_zabbix_server"/ssl_keys:/var/lib/zabbix/ssl/keys \
	-v "$project_path"/"$container_zabbix_server"/ssl_ca:/var/lib/zabbix/ssl/ssl_ca \
	-v "$project_path"/"$container_zabbix_server"/mibs:/var/lib/zabbix/mibs \
	-e DB_SERVER_HOST="$container_zabbix_mysql_server" \
	-e MYSQL_DATABASE="$mysql_db_name" \
	-e MYSQL_USER="$mysql_user" \
	-e MYSQL_PASSWORD="$mysql_user_pass" \
	-e MYSQL_ROOT_PASSWORD="$my_sql_root_pass" \
    --network="$containers_network" \
	-p 10051:10051 \
	--restart unless-stopped \
	-d zabbix/zabbix-server-mysql:alpine-6.4-latest
	



	# -e ZBX_JAVAGATEWAY="$zabbixJavaGatewayContName" \
    # -e ZBX_ENABLE_SNMP_TRAPS="true" \
    # $linkSnmpTraps \

    
    
    
    


