#!/usr/bin/env bash


docker kill mongo
docker kill hypervaultrest
docker rm hypervaultrest

docker start mongo

source .env

docker run \
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
-p 2019:3000 \
hypervault/rest-server

echo "Server should now be listening on localhost at port 2019"
echo "Run 'docker logs hypervaultrest' to see the logs. "

echo 
echo '---------------------------------------'
echo "Setting up reverse proxy to map composer.hypervault.tech --> localhost:2019"
echo '---------------------------------------'
sudo cp ./composer.hypervault.tech.conf /etc/nginx/conf.d/composer.hypervault.tech.conf
sudo systemctl restart nginx
