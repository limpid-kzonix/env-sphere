#!/bin/bash

IMAGE_NAME="limpidkzonix/jenkins-jnlp-slave:arm"
docker rmi "$IMAGE_NAME" -f
docker build -t "$IMAGE_NAME" .