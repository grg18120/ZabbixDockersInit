#!/bin/bash
PROJECT_PATH="$(pwd)"

source "$PROJECT_PATH/config.sh"
# source "$PROJECT_PATH/lib/dockers_utils.sh"

# delete_container "$container_zabbix_mysql_server"



sh "$PROJECT_PATH/zabbixDockersInit/init-$container_zabbix_mysql_server.sh" \
    -r "$PROJECT_PATH" \
	-c "$container_zabbix_mysql_server"

# sh "$PROJECT_PATH/zabbixDockersInit/init-$container_zabbix_mysql_server.sh" \
#   -r "$PROJECT_PATH" \
# 	-c "$container_zabbix_mysql_server" \
# 	-d "$mysql_db_name" \
# 	-r "$my_sql_root_pass" \
# 	-u "$mysql_user" \
# 	-p "$mysql_user_pass" \
# 	-v "$containers_volumes" \
# 	-n "$containers_network"

# Keep the terminal open until you press Enter
read