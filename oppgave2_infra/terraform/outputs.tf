output "sqs_queue_url" {
  description = "URL of the SQS queue"
  value       = aws_sqs_queue.image_queue.id
}