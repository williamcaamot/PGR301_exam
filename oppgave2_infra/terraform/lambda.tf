
# IAM Role for Lambda
resource "aws_iam_role" "lambda_iam_role" {
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

resource "aws_iam_role_policy" "lambda_iam_logging_policy" {
  name = "47-lambda_iam_logging_policy"
  role = aws_iam_role.lambda_iam_role.id  # replace with your Lambda role resource name

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
  name = "47-lambda-bedrock-policy"
  role = aws_iam_role.lambda_iam_role.id  # replace with your Lambda role resource name

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

resource "aws_lambda_function" "image_generation_lambda" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_iam_role.arn
  handler       = "lambda_sqs.lambda_handler"
  runtime       = "python3.9"
  filename = data.archive_file.lambda_zip.output_path
  source_code_hash = filebase64sha256(data.archive_file.lambda_zip.output_path)
  timeout = 30 # Med batch size = 1, og parametre satt i oppgave4, vil dette sørge for at man blir varslet hvis det tar mer enn 45 sekunder å generere et bilde. Ifølge oppgavne tar det inntil 10 sekunder (men kan sikkert ta mer)
  
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
  function_name = aws_lambda_function.image_generation_lambda.function_name
  principal     = "apigateway.amazonaws.com"
}
