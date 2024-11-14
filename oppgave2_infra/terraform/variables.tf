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
    description = "Kandidatnummer for å velge hvilken path som ting skal lagres ved i S3 bucket, kan også brukes for å navngi ressurser"
    type        = string
    default     = "47"
}

variable "sqs_email_for_alarms" {
  description = "The period in seconds over which the metric is evaluated."
  type        = string
  default     = "william-ca@live.no"
}