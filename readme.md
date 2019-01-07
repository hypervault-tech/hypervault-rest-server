# Hypervault REST Server

This is based on https://hyperledger.github.io/composer/latest/tutorials/google_oauth2_rest 

This is a multi-user REST Server that is used to interact with the Hypervault blockchain network. This server uses the port `2019` and it is exposed at http://hypervault.tech:2019/

## Bringing up the server

*All commands are assumed to be run on an Ubuntu server*

The 'server' consists of the following containers: 

1. MongoDB container to permanently store business network cards
2. composer-rest-server container to expose endpoints. 

To bring up (1), simply run 

```
sudo docker run -d --name mongo --network composer_default -p 27017:27017 mongo
```

To build and bring up (2), follow the following steps. 

### Building and bringing up the composer-rest-server

To build the docker image, simply run 

```
sudo docker build -t hypervault/rest-server .
```

where the image name is `hypervault/rest-server`.

Environment variables used by the image are defined in `env` and next load them with 

```
source .env
```

Finally, bring up the docker container by 

```
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
-p 2019:3000 \
hypervault/rest-server
```

where the name of the container is `hypervaultrest`

To check that the container is up and running, simply do 

```
sudo docker ps |grep hypervaultrest
sudo docker logs hypervaultrest
```

If everything goes well, the log should say something like 

```
........
Web server listening at: http://localhost:3000
Browse your REST API at http://localhost:3000/explorer
```

Note that it says the port is 3000, which is mapped to the port `2019` on the host machine. 

### Server restart script

All of the above steps are encapsulated in the script `restartRESTserver.sh` which additionally kills and removes the docker containers first. This script should be run as `sudo`. 