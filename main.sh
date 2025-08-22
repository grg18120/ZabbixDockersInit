#!/bin/bash
PROJECT_PATH="$(pwd)"

#Imports
source "$PROJECT_PATH/config.sh"
source "$PROJECT_PATH/lib/dockers_utils.sh"


# Dockers
# ------------------- ZABBIX MYSQL SERVER ------------------- #
delete_container "$container_zabbix_mysql_server"
sh "$PROJECT_PATH/zabbixDockersInit/init-$container_zabbix_mysql_server.sh" \
    -x "$PROJECT_PATH" \
	-c "$container_zabbix_mysql_server" \
	-d "$mysql_db_name" \
	-r "$my_sql_root_pass" \
	-u "$mysql_user" \
	-p "$mysql_user_pass" \
	-v "$containers_volumes" \
	-n "$containers_network"


# ------------------- ZABBIX SERVER ------------------- #
delete_container "$container_zabbix_server"
sh "$PROJECT_PATH/zabbixDockersInit/init-$container_zabbix_server.sh" \
    -x "$PROJECT_PATH" \
    -c "$container_zabbix_server" \
    -m "$container_zabbix_mysql_server" \
    -d "$mysql_db_name" \
	-r "$my_sql_root_pass" \
	-u "$mysql_user" \
	-p "$mysql_user_pass" \
	-v "$containers_volumes" \
	-n "$containers_network"


# ------------------- ZABBIX AGENT ------------------- #
delete_container "$container_zabbix_agent"
sh "$PROJECT_PATH/zabbixDockersInit/init-$container_zabbix_agent.sh" \
    -x "$project_path" \
    -c "$container_zabbix_agent" \
    -z "$container_zabbix_server" \
    -n "$containers_network"


# ------------------- ZABBIX WEB INTERFACE NGX SERVER ------------------- #
delete_container "$container_zabbix_web_ngx"
bash "$PROJECT_PATH/zabbixDockersInit/init-$container_zabbix_web_ngx.sh \
    -x "$project_path" \
    -c "$container_zabbix_web_ngx" \
    -z "$container_zabbix_server" \
    -m "$container_zabbix_mysql_server" \
    -d "$mysql_db_name" \
	-r "$my_sql_root_pass" \
	-u "$mysql_user" \
	-p "$mysql_user_pass" \
	-w "$http_port" \
	-n "$containers_network"

# Keep the terminal open until you press Enter
read