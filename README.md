# Setting up gRPC with go-modules


## Init

Initialize a project outside of the `$GOPATH` with name `grpcconsul`.
```bash
# go mod init <project_name>
$ go mod init grpcconsul

# If you are initializing inside the $GOPATH to take advantage of vendoring...
$ GO111MODULES=on go mod init grpcconsul
```

## Install

Install or update the necessary dependencies:
```bash
$ make install 
install:
	@go get -u github.com/golang/protobuf/{proto,protoc-gen-go}
	@go get -u google.golang.org/grpc
```

## Protol

Compiles the protobuf files (`*.proto`) in the `proto/` directory:

```bash
$ make proto
proto:
	@echo Compiling proto files...
	@find **/*.proto -exec protoc --go_out=plugins=grpc:. {} \;
	@echo Done!
```

## Start Server Manually

```bash
$ go run server/server.go
```
Output:

```bash
2018/09/09 14:18:06 listening to port:50051. press ctrl+c to cancel.
```
 
## Start Client Manually

```bash
$ go run client/client.go "John Doe"
```

Output:

```bash
2018/09/09 14:19:04 Greeting: Hello John Doe
```

## Dockerize

Dockerfiles are included and placed in the client and server folder respectively. This is to honor the naming of the Dockerfile (should not contain any suffix like `Dockerfile.client` etc). To build:

```bash
# Note that I use the alias dc to represent docker-compose here to reduce typing.
$ alias dc=docker-compose
$ dc build
```

Verify the build:

```bash
$ docker images | grep grpcconsul
```

Output:

```
grpcconsul/server                  latest                  663ddba0d99f        15 minutes ago      16.9MB
grpcconsul/client                  latest                  ee276002c1e0        15 minutes ago      16.5MB
```

## Run the server

```bash
$ dc up -d
```

Verify:

```bash
$ dc logs
```

Output:

```
Attaching to grpc-consul_client_1, grpc-consul_server_1
client_1  | 2018/09/09 06:24:53 Greeting: Hello world
server_1  | 2018/09/09 06:24:52 listening to port:50051. press ctrl+c to cancel.
```

## Clean

```bash
# Stop all running servers
$ dc down

# Prune unused image, network and volume.
$ docker system prune
```
