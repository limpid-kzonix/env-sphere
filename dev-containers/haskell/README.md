```shell
docker buildx build --platform=linux/amd64 --push -t worxbend/haskell-dev-container:latest -t worxbend/haskell-dev-container:1 worxbend/haskell-dev-container:1.0 -t worxbend/haskell-dev-container:alpine -t worxbend/haskell-dev-container:1-alpine  -f haskell.Dockerfile .
```