variable "cluster_name" {
  description = "EKS 클러스터 이름"
  type        = string
}

variable "subnet_ids" {
  description = "EKS 클러스터가 사용할 프라이빗 서브넷 ID 목록"
  type        = list(string)
}