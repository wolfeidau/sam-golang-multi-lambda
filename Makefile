# fall back to git hash for local builds
RELEASE_VERSION ?= $(shell git rev-parse --short HEAD)

LDFLAGS := -ldflags "-s -w -X main.commit=$(VERSION)"
BUILDFLAGS := -tags lambda.norpc

GOARCH := arm64

# default target, note it passes through a version to the builds which occur in ~/.aws-sam/build scratch folder
.PHONY: build
build:
	VERSION=$(RELEASE_VERSION) \
		sam build

# name matches the logical name of the lambda function in the SAM file
build-APIFunction:
	GOARCH=$(GOARCH) GOOS=linux go build $(BUILDFLAGS) $(LDFLAGS) -o ./bootstrap cmd/api-lambda/main.go
	cp ./bootstrap $(ARTIFACTS_DIR)/.

# name matches the logical name of the lambda function in the SAM file
build-ScheduledFunction:
	GOARCH=$(GOARCH) GOOS=linux go build $(BUILDFLAGS) $(LDFLAGS) -o ./bootstrap cmd/scheduled-lambda/main.go
	cp ./bootstrap $(ARTIFACTS_DIR)/.