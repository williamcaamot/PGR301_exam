# IAM Policy for logging to cloudwatch
resource "aws_iam_role_policy" "lambda_iam_logging_policy" {
  name = "47-lambda_iam_logging_policy"
  role = aws_iam_role.lambda_iam_role.id

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

# General IAM Policy for Bedrock, s3 and SQS
resource "aws_iam_role_policy" "lambda_iam_image_generation_policy" {
  name = "47-lambda-bedrock-policy"
  role = aws_iam_role.lambda_iam_role.id  # replace with your Lambda role resource name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "bedrock:InvokeModel",
        Effect = "Allow",
        Resource = "arn:aws:bedrock:us-east-1::foundation-model/amazon.titan-image-generator-v1"
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