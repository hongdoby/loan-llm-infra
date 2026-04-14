# 1. 리스트에 있는 유저들을 EKS 클러스터에 등록 (Access Entry)
resource "aws_eks_access_entry" "admin_users" {
  # var.admin_users 리스트를 set 형태로 변환하여 반복문 실행
  for_each = toset(var.admin_users)

  cluster_name      = aws_eks_cluster.eks_cluster.name
  
  # each.value는 리스트 안의 ARN 문자열을 하나씩 꺼내온 값입니다.
  principal_arn     = each.value 
  type              = "STANDARD"
}

# 2. 등록된 각각의 유저에게 클러스터 최고 관리자(Admin) 권한 연결
resource "aws_eks_access_policy_association" "admin_policy" {
  for_each = toset(var.admin_users)

  cluster_name  = aws_eks_cluster.eks_cluster.name
  principal_arn = aws_eks_access_entry.admin_users[each.key].principal_arn
  
  # AWS 제공 EKS 최고 관리자 정책 ARN
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  
  access_scope {
    type = "cluster"
  }
}