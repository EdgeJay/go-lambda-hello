# IAM role for Lambda
resource "aws_iam_role" "lambda_exec" {
  name = "lambda_exec_role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [{
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      }
    }]
  })
}

# Policy for Lambda to allow logging to CloudWatch
resource "aws_iam_role_policy" "lambda_exec_policy" {
  role = aws_iam_role.lambda_exec.id

  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [{
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:logs:*:*:*"
    }]
  })
}

# Permission for API Gateway to invoke the Lambda function
resource "aws_lambda_permission" "go_lambda_hello_api_invoke" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.go_lambda_hello_func.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.go_lambda_hello_api.execution_arn}/*/*"
}

# Create Lambda function in Go
resource "aws_lambda_function" "go_lambda_hello_func" {
  function_name = "go-lambda-hello"
  runtime       = "provided.al2023"
  role          = aws_iam_role.lambda_exec.arn
  handler       = "main"
  filename      = "./build/bootstrap.zip"   # Path to the Go binary zipped
  source_code_hash = filebase64sha256("./build/bootstrap.zip")

  environment {
  }
}
