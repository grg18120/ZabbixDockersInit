#!/bin/bash

# Imports
source "$PROJECT_PATH/config.sh"

#"$(container_is_running "my_container")"
container_is_running(){
    container=$1

    VAR1="$(docker container inspect -f '{{.State.Status}}' $container)"
    VAR2="running"

  if [ "$VAR1" = "$VAR2" ]; then
        echo true
    else
        echo false
    fi
}

#delete "my_container"
delete_container(){
    $container=$1

    if "$(container_is_running $container)";then
        echo "Docker Container $container exists and is running!, Stop container"
        docker container stop $container
    fi
    docker container rm $container
    echo "Docker Container $container has been deleted"
}

#dockers_scripts_permissions "${dockersList[@]}"
dockers_scripts_permissions() {
	local docList=("$@")
	for doc in "${docList[@]}"; do
		chmod 777 $PROJECT_PATH/bin/otherBashScripts/init-$doc.sh
		sed -i -e "s/\r$//" $PROJECT_PATH/bin/otherBashScripts/init-$doc.sh
	done
}