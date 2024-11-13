
# IAM Role for Lambda
resource "aws_iam_role" "lambda_role" {
  name = "47-iam-lambda-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# Add IAM policy for Lambda access to specific SQS queue
resource "aws_iam_role_policy" "lambda_sqs_policy" {
  name = "47-lambda-sqs-policy"
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ],
        Effect = "Allow",
        Resource = aws_sqs_queue.image_queue.arn
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_logging_policy" {
  name = "lambda-logging-policy"
  role = aws_iam_role.lambda_role.id  # replace with your Lambda role resource name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:*:*:*"
      }
    ]
  })
}

resource "aws_iam_role_policy" "labda_bedrock_policy" {
  name = "lambda-bedrock-policy"
  role = aws_iam_role.lambda_role.id  # replace with your Lambda role resource name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "bedrock:InvokeModel",
          "s3:PutObject",
        ],
        Resource = "*"
      }
    ]
  })
}


# Zip the Lambda function code
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "../lambda_sqs.py"
  output_path = "${path.module}/lambda_function.zip"
}

# Create the Lambda function
# see  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function.html

resource "aws_lambda_function" "infra_lambda_47" {
  function_name = "47-infra-lambda"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_sqs.lambda_handler"
  runtime       = "python3.9"
  filename = data.archive_file.lambda_zip.output_path
  source_code_hash = filebase64sha256(data.archive_file.lambda_zip.output_path)
  timeout = 120
  
  environment {
    variables = {
      BUCKET_NAME = "pgr301-couch-explorers"
    }
  }
  
}

# Create a Lambda permission to allow invocation
resource "aws_lambda_permission" "allow_invocation" {
  statement_id  = "AllowExecutionFromAPI"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.infra_lambda_47.function_name
  principal     = "apigateway.amazonaws.com"
}
