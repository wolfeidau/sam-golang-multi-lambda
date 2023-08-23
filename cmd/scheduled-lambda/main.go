package main

import (
	"fmt"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

var (
	commit = "dev"
)

func handler(evt events.CloudWatchEvent) error {
	return nil
}

func main() {
	fmt.Printf("version=%s\n", commit)

	lambda.Start(handler)
}
