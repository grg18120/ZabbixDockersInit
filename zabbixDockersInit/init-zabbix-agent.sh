#!/bin/bash 

# Variables
while getopts x:c:z:n: flag
do
    case "${flag}" in
        x) project_path=${OPTARG};;
        c) container_zabbix_agent=${OPTARG};;
		z) container_zabbix_server=${OPTARG};;
        n) containers_network=${OPTARG};;  
    esac
done
	
docker run --name $container_zabbix_agent \
    -v "$project_path"/"$container_zabbix_agent"/agent2_conf:/etc/zabbix/zabbix_agentd.d \
    -v "$project_path"/"$container_zabbix_agent"/agent2_tls:/var/lib/zabbix/enc \
    -e ZBX_SERVER_HOST="$container_zabbix_server" \
    -e ZBX_ACTIVE_ALLOW="false" \
    --link "$container_zabbix_server":zabbix-server \
    --network="$containers_network" \
    --privileged \
    --init \
    --restart=unless-stopped \
    -d zabbix/zabbix-agent2:alpine-6.4-latest