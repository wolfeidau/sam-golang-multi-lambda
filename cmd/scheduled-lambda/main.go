package main

import (
	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

func handler(evt events.CloudWatchEvent) error {
	return nil
}

func main() {
	lambda.Start(handler)
}
