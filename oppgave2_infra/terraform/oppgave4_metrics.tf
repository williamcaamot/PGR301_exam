# CloudWatch Alarm for ApproximateAgeOfOldestMessage
resource "aws_cloudwatch_metric_alarm" "sqs_approximate_age_of_oldest_message" {
  alarm_name          = "${var.sqs_queue_name}-ApproximateAgeOfOldestMessage"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "ApproximateAgeOfOldestMessage"
  namespace           = "AWS/SQS"
  period              = var.sqs_alarm_period
  statistic           = "Maximum"
  threshold           = var.sqs_alarm_threshold
  alarm_description   = "Alarm when the age of the oldest message in the SQS queue exceeds ${var.sqs_alarm_threshold} seconds."

  dimensions = {
    QueueName = aws_sqs_queue.image_queue.name
  }

  alarm_actions = [
    aws_sns_topic.sqs_alarms.arn
  ]
}

# SNS Topic for CloudWatch Alarms
resource "aws_sns_topic" "sqs_alarms" {
  name = "${var.sqs_queue_name}-sqs-alarms"
}

# SNS Subscription (e.g., Email)
resource "aws_sns_topic_subscription" "sqs_alarms_subscription" {
  topic_arn = aws_sns_topic.sqs_alarms.arn
  protocol  = "email"
  endpoint  = var.sqs_email_for_alarms
}
