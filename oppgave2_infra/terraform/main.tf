terraform {
  required_version = "> 1.9.0"

  backend "s3" {
    bucket = "pgr301-2024-terraform-state"
    key    = "47/state.tfstate"
    region = "eu-west-1"
    encrypt = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.74.0"
    }
  }
}

# Specify the Terraform provider (in this case, AWS)
provider "aws" {
  region = "eu-west-1"
}


module "lambda_function" {
  source               = "./modules/lambda"
  function_name        = var.lambda_function_name
  runtime              = "python3.9"
  handler              = "lambda_sqs.lambda_handler"
  role_arn             = aws_iam_role.lambda_iam_role.arn
  source_file          = "../lambda_sqs.py"
  timeout              = 30 # Med batch size = 1, og parametre satt i oppgave4, vil dette sørge for at man blir varslet hvis det tar mer enn 45 sekunder å generere et bilde. Ifølge oppgavne tar det inntil 10 sekunder (men kan sikkert ta mer)
  environment_variables = {
    BUCKET_NAME    = var.bucket_name
    KANDIDATNUMMER = var.kandidatnummer
  }
}
