package main

import (
	"testing"

	"github.com/aws/aws-lambda-go/events"
)

func TestHandler(t *testing.T) {
	testCases := []struct {
		name          string
		request       events.CloudWatchEvent
		expectedBody  string
		expectedError error
	}{
		{
			// mock a request with an empty SourceIP
			name:          "empty Event",
			request:       events.CloudWatchEvent{},
			expectedError: nil,
		},
	}

	for _, testCase := range testCases {
		t.Run(testCase.name, func(t *testing.T) {
			err := handler(testCase.request)
			if err != testCase.expectedError {
				t.Errorf("Expected error %v, but got %v", testCase.expectedError, err)
			}
		})
	}
}
