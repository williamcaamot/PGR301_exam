# Archive the Lambda function code
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = var.source_file
  output_path = "${path.module}/lambda_function.zip"
}

# Define the Lambda function
resource "aws_lambda_function" "lambda" {
  function_name    = var.function_name
  handler          = var.handler
  runtime          = var.runtime
  role             = var.role_arn
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = filebase64sha256(data.archive_file.lambda_zip.output_path)
  timeout          = var.timeout

  environment {
    variables = var.environment_variables
  }
}

# Define permissions for the Lambda function
resource "aws_lambda_permission" "invoke_permission" {
  statement_id  = "AllowExecutionFromAPI"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = var.principal
}
