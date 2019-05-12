ROOT:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
IMAGE_NAME:=kzonix/jnlp-slave:arm

build:
	docker rmi ${IMAGE_NAME} -f
	docker build -t ${IMAGE_NAME} .
