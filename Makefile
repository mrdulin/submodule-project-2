
INTEGRATION_TEST_FUNC_NAME_SUFFIX=Integration
GOPATH_FIRST=$(shell echo $$GOPATH | cut -d':' -f1)

compile-protobuf:
	protoc \
		-I . \
		-I ${GOPATH_FIRST}/pkg/mod/github.com/envoyproxy/protoc-gen-validate@v0.4.1 \
		--go_out=. \
		--go-grpc_out=. \
		--go_opt=paths=source_relative \
		--go-grpc_opt=paths=source_relative \
		--validate_out=paths=source_relative,lang=go:. \
		./internal/protobufs/**/*.proto

start:
	go run ./cmd/server/main.go

test-integration:
	go test -run ${INTEGRATION_TEST_FUNC_NAME_SUFFIX} -v ./...

test-unit:
	go test -v --short ./...
