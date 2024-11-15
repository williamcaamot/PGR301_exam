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
