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