#!/bin/bash

docker_bash() {
    docker run -it --rm -P $1 /bin/bash 
  }
