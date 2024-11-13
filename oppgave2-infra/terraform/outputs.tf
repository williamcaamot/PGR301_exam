output "lambda_function_url" {
  description = "URL for invoking the Lambda function"
  value       = aws_lambda_function.infra_lambda_47.invoke_arn
}

output "sqs_queue_url" {
  description = "URL of the SQS queue"
  value       = aws_sqs_queue.image_queue.id
}