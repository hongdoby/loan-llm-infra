provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "4team-cloud-tfstate"
}

# 상태 파일의 히스토리 관리를 위한 버전 관리 활성화
resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# 상태 잠금(Locking)을 위한 DynamoDB 테이블 생성
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "4team-cloud-tfstate"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}