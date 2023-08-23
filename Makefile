APP_NAME	    	:= sam-golang-multi-lambda

GIT_HASH    		?= $(shell git rev-parse --short HEAD)
STAGE	    		?= dev
BRANCH      		?= master

LDFLAGS := '-ldflags=-s -w -X=main.commit=$(GIT_HASH)'

GOARCH := arm64

export GOFLAGS = -tags=lambda.norpc -trimpath $(LDFLAGS)

# default target, note it passes through a version to the builds which occur in ~/.aws-sam/build scratch folder
.PHONY: build
build:
	@echo "GOFLAGS=$(GOFLAGS)"
	@sam build

.PHONY: clean
clean:
	rm -rf .aws-sam

.PHONY: deploy
deploy:
	sam deploy --s3-prefix $(APP_NAME) --stack-name $(APP_NAME)-$(STAGE)-$(BRANCH) --capabilities CAPABILITY_IAM \
		--tags "environment=$(STAGE)" "branch=$(BRANCH)" "service=$(APP_NAME)"