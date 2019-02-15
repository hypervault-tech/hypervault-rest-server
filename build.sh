#!/usr/bin/env bash

echo "Building hypervault/composer-rest-server-fork"
source ./composer-rest-server/docker/build.sh

echo "Building the hypervault/rest-server image"
docker build -t hypervault/rest-server .

