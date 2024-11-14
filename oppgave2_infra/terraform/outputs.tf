output "lambda_function_url" {
  description = "URL for invoking the Lambda function"
  value       = aws_lambda_function.image_generation_lambda.invoke_arn
}

output "sqs_queue_url" {
  description = "URL of the SQS queue"
  value       = aws_sqs_queue.image_queue.id
}