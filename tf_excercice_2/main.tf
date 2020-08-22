provider "aws" {
  region     = var.aws_region
  access_key = "...."
  secret_key = "...."
}

resource "aws_iam_role" "udp2_role" {
  name = "udp2_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "udp2_role_log_policy" {
  name = "udp2_role_log_policy"
  role = aws_iam_role.udp2_role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "logs:CreateLogGroup",
            "Resource": "arn:aws:logs:us-east-1:717688022733:*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:us-east-1:717688022733:log-group:/aws/lambda/ndp2_lambda"
            ]
        }
    ]
}
EOF
}

resource "aws_lambda_function" "ndp2_lambda" {
  filename      = "lambda.py.zip"
  function_name = "ndp2_lambda"
  role          = aws_iam_role.udp2_role.arn
  handler       = "lambda.lambda_handler"

  source_code_hash = filebase64sha256("lambda.py.zip")

  runtime = "python3.7"

  environment {
    variables = {
      greeting = "Howdy"
    }
  }
}
