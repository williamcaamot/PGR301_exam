
# Event Source Mapping to trigger Lambda from SQS
resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  event_source_arn = aws_sqs_queue.image_queue.arn
  function_name    = aws_lambda_function.image_generation_lambda.arn
  batch_size       = 1
  enabled          = true
}

resource "aws_sqs_queue" "image_queue" {
  name = var.sqs_queue_name
  visibility_timeout_seconds = 180 #From this source: https://stackoverflow.com/questions/77560110/why-should-the-sqs-visibility-timeout-for-lambda-bet-set-to-6
  # 180 seconds aligns with 6 * 30 seconds which is lambda timeout
}