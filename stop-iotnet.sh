#!/bin/bash

containers=$(docker network inspect iotnet -f '{{range .Containers}}{{.Name}} {{end}}')

if [ -z "$containers" ]; then
  echo "No containers are connected to the iotnet network."
else
  echo "Stopping containers in the iotnet network..."
  for container in $containers; do
    docker stop "$container"
    echo "Stopped container: $container"
  done
fi