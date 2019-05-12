#!/bin/bash

IMAGE_NAME="kzonix/jnlp-slave:arm"
docker rmi "$IMAGE_NAME" -f
docker build -t "$IMAGE_NAME" .