# Name of the Lambda function
variable "function_name" {
  description = "The name of the Lambda function"
  type        = string
}

# Runtime for the Lambda function
variable "runtime" {
  description = "The runtime for the Lambda function (e.g., python3.9)"
  type        = string
}

# Handler for the Lambda function
variable "handler" {
  description = "The handler for the Lambda function (e.g., app.lambda_handler)"
  type        = string
}

# Role ARN for the Lambda function
variable "role_arn" {
  description = "The ARN of the IAM role to assign to the Lambda function"
  type        = string
}

# Timeout for the Lambda function
variable "timeout" {
  description = "Timeout for the Lambda function in seconds"
  type        = number
  default     = 30
}

# Source file for the Lambda function code
variable "source_file" {
  description = "The source file for the Lambda function code"
  type        = string
}

# Environment variables for the Lambda function
variable "environment_variables" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}

# Principal for the Lambda permissions (e.g., API Gateway)
variable "principal" {
  description = "The principal allowed to invoke the Lambda function"
  type        = string
  default     = "apigateway.amazonaws.com"
}
