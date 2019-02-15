#!/usr/bin/env bash

echo "Building hypervault/composer-rest-server-fork"
cd ./composer-rest-server/docker/
docker build -t hypervault/composer-rest-server-fork . --no-cache

echo "Building the hypervault/rest-server image"
docker build -t hypervault/rest-server . --no-cache

