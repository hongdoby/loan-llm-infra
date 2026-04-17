terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "loan-cloud-tfstate"
    key            = "loan-llm/terraform.tfstate"
    region         = "ap-northeast-2"
    dynamodb_table = "loan-cloud-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "loan-llm"
      ManagedBy   = "terraform"
    }
  }

}