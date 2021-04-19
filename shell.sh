#!/usr/bin/env bash

# shell.sh

# run the container in the background
# /data is persisted using a named container

docker run \
    --rm \
    -it \
    -p 8080:80 \
    --name="evasive_apache" \
    evasive_apache \
    /bin/bash