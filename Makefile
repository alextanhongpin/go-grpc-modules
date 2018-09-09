.PHONY: proto

install:
	@go get -u github.com/golang/protobuf/{proto,protoc-gen-go}
	@go get -u google.golang.org/grpc
	# protoc --go_out=plugins=grpc:. *.proto
	
proto:
	@echo Compiling proto files...
	@find **/*.proto -exec protoc --go_out=plugins=grpc:. {} \;
	@echo Done!
