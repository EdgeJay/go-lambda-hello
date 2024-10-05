build:
	@rm -rf ./build
	@CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ./build/main ./main.go
	@zip ./build/main.zip ./build/main
	@cd ../terraform && mkdir ./build
	@cd ../app && mv ./build/main.zip ../terraform/build/main.zip

.PHONY: build