#!/bin/bash

if ! docker network inspect iotnet >/dev/null 2>&1; then
  echo "Creating iotnet network..."
  docker network create --driver bridge --subnet 192.168.2.0/24 --gateway 192.168.2.1 iotnet
else
  echo "iotnet network already exists."
fi