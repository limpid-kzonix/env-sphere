
```shell
docker buildx build --platform=linux/amd64 --push -t worxbend/elixir-dev-container:latest -t worxbend/elixir-dev-container:1 -t worxbend/elixir-dev-container:1.0 -t worxbend/elixir-dev-container:alpine -t worxbend/elixir-dev-container:1-alpine -f elixir.Dockerfile .
```