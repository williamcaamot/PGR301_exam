# variables.tf
variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = "47-infra-lambda"
}

variable "sqs_queue_name" {
  description = "Name of the SQS queue"
  type        = string
  default     = "47-image-queue"
}

variable "bucket_name" {
  description     = "S3 bucket name for Lambda storage"
  type            = string
  default         = "pgr301-couch-explorers"
}

variable "kandidatnummer" {
    description = "Kandidatnummer to select in what path to save images in bucket"
    type        = string
    default     = "47"
}


variable "sqs_alarm_threshold" {
  description = "Threshold for the ApproximateAgeOfOldestMessage metric in seconds."
  type        = number
  default     = 30  # Default to 10 minutes
}

variable "sqs_alarm_period" {
  description = "The period in seconds over which the metric is evaluated."
  type        = number
  default     = 60  # Default to 5 minutes
}

variable "sqs_email_for_alarms" {
  description = "The period in seconds over which the metric is evaluated."
  type        = string
  default     = "william-ca@live.no"
}