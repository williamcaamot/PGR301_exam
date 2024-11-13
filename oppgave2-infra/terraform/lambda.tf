
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

resource "aws_iam_role_policy" "lambda_bedrock_policy" {
  name = "lambda-bedrock-policy"
  role = aws_iam_role.lambda_role.id  # replace with your Lambda role resource name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "bedrock:InvokeModel",
        Effect = "Allow",
        Resource = "*" # TODO Should possibly fix this to be less priviledged
      },
      {
        Action: "s3:PutObject",
        Effect: "Allow",
        Resource = "arn:aws:s3:::pgr301-couch-explorers/47/*"
      },
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


# Zip the Lambda function code
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "../lambda_sqs.py"
  output_path = "${path.module}/lambda_function.zip"
}

# Create the Lambda function
# see  https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function.html

resource "aws_lambda_function" "infra_lambda_47" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_sqs.lambda_handler"
  runtime       = "python3.9"
  filename = data.archive_file.lambda_zip.output_path
  source_code_hash = filebase64sha256(data.archive_file.lambda_zip.output_path)
  timeout = 120
  
  environment {
    variables = {
      BUCKET_NAME = var.bucket_name
      KANDIDATNUMMER = var.kandidatnummer
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
