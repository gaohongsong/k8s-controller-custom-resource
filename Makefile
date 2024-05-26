TARGET=samplecrd-controller
CUSTOM_RESOURCE=samplecrd:v1

.PHONY: tidy
tidy:
	go mod tidy

.PHONY: clear
clear:
	@go clean -i ./...
	@rm -f samplecrd-controller

.PHONY: build
build: clear
	@CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ${TARGET} .

.PHONY: regenerate
regenerate:
	mkdir ./pkg/client/clientset ./pkg/client/informers ./pkg/client/listers -p
	./hack/update-codegen.sh
