# Create an API Gateway HTTP API
resource "aws_apigatewayv2_api" "go_lambda_hello_api" {
  name          = "go-lambda-hello-api"
  protocol_type = "HTTP"
}

# Integrate API Gateway with Lambda function
resource "aws_apigatewayv2_integration" "go_lambda_hello_func_integration" {
  api_id           = aws_apigatewayv2_api.go_lambda_hello_api.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.go_lambda_hello_func.invoke_arn
}

# Define a route for Lambda function
resource "aws_apigatewayv2_route" "go_lambda_hello_route" {
  api_id    = aws_apigatewayv2_api.go_lambda_hello_api.id
  route_key = "GET /hello"
  target    = "integrations/${aws_apigatewayv2_integration.go_lambda_hello_func_integration.id}"
}

# Deploy the API
resource "aws_apigatewayv2_stage" "default_stage" {
  api_id      = aws_apigatewayv2_api.go_lambda_hello_api.id
  name        = "$default"
  auto_deploy = true
}
