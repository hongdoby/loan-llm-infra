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
  default = "10.0.0.0/22"   # 대역: 10.0.0.0 ~ 10.0.3.255
}

variable "public_subnet_2c_cidr" {
  default = "10.0.4.0/22"   # 대역: 10.0.4.0 ~ 10.0.7.255
}

variable "private_subnet_2a_cidr" {
  default = "10.0.8.0/22"   # 대역: 10.0.8.0 ~ 10.0.11.255
}

variable "private_subnet_2c_cidr" {
  default = "10.0.12.0/22"  # 대역: 10.0.12.0 ~ 10.0.15.255
}

variable "azs" {
  type    = list(string)
  default = ["ap-northeast-2a", "ap-northeast-2c"]

}