package main

import (
	"context"
	"encoding/json"
	"log"

	"github.com/aws/aws-lambda-go/events"
	"github.com/aws/aws-lambda-go/lambda"
)

// Response structure for the API
type Response struct {
	Status  string `json:"status"`
	Message string `json:"message"`
}

// Handler function for the Lambda
func handler(ctx context.Context, request events.APIGatewayProxyRequest) (events.APIGatewayProxyResponse, error) {
	log.Printf("Received request: %s", request.Body)

	// Simulating a read operation, e.g., fetching data from a database or returning a static response
	data := map[string]string{
		"id":   "1",
		"name": "Sample Item",
	}

	// Marshal the data into JSON
	responseBody, err := json.Marshal(data)
	if err != nil {
		return events.APIGatewayProxyResponse{
			StatusCode: 500,
			Body:       `{"error": "Unable to marshal response"}`,
		}, err
	}

	// Return the response with status 200
	return events.APIGatewayProxyResponse{
		StatusCode: 200,
		Body:       string(responseBody),
		Headers: map[string]string{
			"Content-Type": "application/json",
		},
	}, nil
}

func main() {
	lambda.Start(handler)
}
