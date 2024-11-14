terraform {
  required_version = "> 1.9.0"

  backend "s3" {
    bucket = "pgr301-2024-terraform-state"
    key    = var.kandidatnummer + "/state.tfstate"
    region = "eu-west-1"
    encrypt = true
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