terraform {
  required_version = "> 1.9.0"

  backend "s3" {
    bucket = "pgr301-2024-terraform-state"  # Name of the existing bucket
    key    = "47/state.tfstate"      # Path within the bucket to store the state file
    region = "eu-west-1"
    encrypt = true                          # Encrypt the state at rest
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "> 5.74.0"
    }
  }
}

# Specify the Terraform provider (in this case, AWS)
provider "aws" {
  region = "eu-west-1"
}