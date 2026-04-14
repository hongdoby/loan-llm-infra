variable "cluster_name" {
  description = "EKS 클러스터 이름"
  type        = string
}

variable "subnet_ids" {
  description = "EKS 클러스터가 사용할 프라이빗 서브넷 ID 목록"
  type        = list(string)
}

# modules/eks-cluster/variables.tf 파일에 추가
variable "admin_users" {
  description = "EKS 클러스터 최고 관리자 권한을 부여할 IAM 유저 ARN 목록"
  type        = list(string)
}