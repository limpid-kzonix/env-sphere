```shell
docker buildx build --push --platform linux/amd64,linux/arm64 -t worxbend/base-dev-container:latest -t worxbend/base-dev-container:1  -t worxbend/base-dev-container:1.0 -t worxbend/base-dev-container:1.0.2 -f base.Dockerfile .
```