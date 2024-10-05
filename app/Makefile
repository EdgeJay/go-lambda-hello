build:
	@rm -rf ./build
	@rm -rf ../terraform/build
	@CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ./build/bootstrap ./main.go
	@cd ./build && zip ./bootstrap.zip ./bootstrap
	@cd ../terraform && mkdir ./build
	@mv ./build/bootstrap.zip ../terraform/build/bootstrap.zip

.PHONY: build