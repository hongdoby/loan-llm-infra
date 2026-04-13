terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  # 모든 리소스에 공통으로 적용될 기본 태그
  default_tags {
    tags = {
      Project     = "loan-llm"
      ManagedBy   = "terraform"
    }
  }
}