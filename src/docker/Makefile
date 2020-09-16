WORDPRESS_NETWORK_NAME=wp-bridge-nw

DATABASE_CONTAINER_NAME=wp-db
DATABASE_USER=wp-db
DATABASE_NAME=wp-db
DATABASE_PASSWORD=geheim41
DATABASE_PORT=3306

run-wordpress:
	docker run \
		--name vw-wordpress \
		--network ${WORDPRESS_NETWORK_NAME} \
		-e WORDPRESS_DB_HOST=${DATABASE_CONTAINER_NAME}:${DATABASE_PORT} \
		-e WORDPRESS_DB_USER=${DATABASE_USER} \
		-e WORDPRESS_DB_NAME={DATABASE_NAME} \
		-e WORDPRESS_DB_PASSWORD={DATABASE_PASSWORD} \
		-d wordpress

rm-wordpress:
	docker stop vw-wordpress && docker rm vw-wordpress


run-mysql:
	docker run \
		--name ${DATABASE_CONTAINER_NAME} \
		--network ${WORDPRESS_NETWORK_NAME} \
		-e MYSQL_ROOT_PASSWORD=${DATABASE_PASSWORD} \
		-e MYSQL_USER=${DATABASE_USER} \
		-e MYSQL_DATABASE=${DATABASE_NAME} \
		-e MYSQL_ROOT_PASSWORD=${DATABASE_PASSWORD} \
		-d mysql:latest

rm-mysql:
	docker stop ${DATABASE_CONTAINER_NAME} && docker rm ${DATABASE_CONTAINER_NAME}

create_wp_nw:
	docker network create -d bridge ${WORDPRESS_NETWORK_NAME}
