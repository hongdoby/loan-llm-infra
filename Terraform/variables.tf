variable "aws_region" {
  default = "ap-northeast-2"
}

variable "cluster_name" {
  default = "loan-llm-cluster"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_2a_cidr" {
  default = "10.0.1.0/24"
}

variable "public_subnet_2c_cidr" {
  default = "10.0.2.0/24"
}

variable "private_subnet_2a_cidr" {
  default = "10.0.11.0/24"
}

variable "private_subnet_2c_cidr" {
  default = "10.0.12.0/24"
}