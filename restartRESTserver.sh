#!/usr/bin/env bash
# set -x #print all commands

docker kill mongo
docker rm mongo
docker kill hypervaultrest
docker rm hypervaultrest

docker run -d --name mongo --network composer_default -p 27017:27017 mongo

echo "Building the docker container"
docker build -t hypervault/rest-server .
source .env

sudo docker run \
-d \
-e COMPOSER_CARD=${COMPOSER_CARD} \
-e COMPOSER_NAMESPACES=${COMPOSER_NAMESPACES} \
-e COMPOSER_AUTHENTICATION=${COMPOSER_AUTHENTICATION} \
-e COMPOSER_MULTIUSER=${COMPOSER_MULTIUSER} \
-e COMPOSER_PROVIDERS="${COMPOSER_PROVIDERS}" \
-e COMPOSER_DATASOURCES="${COMPOSER_DATASOURCES}" \
-v ~/.composer:/home/composer/.composer \
--name hypervaultrest \
--network composer_default \
-p 3019:3000 \
hypervault/rest-server

echo "Server should now be listening on port 3019"