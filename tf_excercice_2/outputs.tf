# TODO: Define the output variable for the lambda function.
output "ndp2_lambda" {
  value = aws_lambda_function.ndp2_lambda.invoke_arn
}
