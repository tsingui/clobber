export GO111MODULE=on
export PATH := $(GOPATH)/bin:$(PATH)

BINARY_VERSION?=0.0.1
EXTRA_FLAGS?=-mod=vendor

all: deps build
install:
	go install -v $(EXTRA_FLAGS) -ldflags "-X main.Version=$(BINARY_VERSION)" ./...
build:
	$(shell $(GOPATH)/bin/packr2)
	go build -v $(EXTRA_FLAGS) -ldflags "-X main.Version=$(BINARY_VERSION)" ./...
test:
	go test -v $(EXTRA_FLAGS) -race -coverprofile=coverage.txt -covermode=atomic ./...
clean:
	go clean
	rm -f $(BINARY_NAME)
deps:
	go build -v $(EXTRA_FLAGS) ./...
	go get github.com/gobuffalo/packr/v2/packr2
upgrade:
	go get -u
	go get -u github.com/gobuffalo/packr/v2/packr2
version:
	clobber --version
print:
	@echo "PWD: $(shell pwd)"
	@echo "PATH: $(PATH)"
	@echo "GOPATH: $(GOPATH)"