
# Event Source Mapping to trigger Lambda from SQS
resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  event_source_arn = aws_sqs_queue.image_queue.arn
  function_name    = aws_lambda_function.infra_lambda_47.arn
  batch_size       = 10
  enabled          = true
}

resource "aws_sqs_queue" "image_queue" {
  name = var.sqs_queue_name
}