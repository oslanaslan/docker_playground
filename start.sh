#!/bin/bash

# Build image
docker image build -t localhost:5000/webapp:v1 .
# Create local registry
docker service create --name registry --publish published=5000,target=5000 registry:2
# Push image
docker image push localhost:5000/webapp:v1
curl localhost:5000/v2/_catalog
# Deploy 
docker stack deploy -c docker-compose.yml webapp
# Add web monitor on port 4040
docker service create -p 4040:8080 --constraint=node.role==manager --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock dockersamples/visualizer
