# 1. Worker-1 노드 그룹 (Private-A 배치, On-Demand, BE/ArgoCD용)
resource "aws_eks_node_group" "worker_1" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "worker-1"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  
  # Private-A 서브넷 (var.subnet_ids의 첫 번째 값: 2a)
  subnet_ids      = [var.subnet_ids[0]]

  instance_types = ["t3.large"]
  capacity_type  = "ON_DEMAND"
  disk_size      = 30

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  labels = {
    nodegroup = "worker-1"
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.eks_ecr_read_only,
  ]
}

# 2. Worker-2 노드 그룹 (Private-B 배치, On-Demand, Prometheus용)
resource "aws_eks_node_group" "worker_2" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "worker-2"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  
  # Private-B 서브넷 (var.subnet_ids의 두 번째 값: 2c)
  subnet_ids      = [var.subnet_ids[1]]

  instance_types = ["t3.medium"]
  capacity_type  = "ON_DEMAND"
  disk_size      = 20

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  labels = {
    nodegroup = "worker-2"
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.eks_ecr_read_only,
  ]
}

# 3. AI 노드 그룹 (Private-A 배치, Spot, GPU 연산용)
resource "aws_eks_node_group" "ai_node" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "ai-node"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  
  # Private-A 서브넷 (var.subnet_ids의 첫 번째 값: 2a)
  subnet_ids      = [var.subnet_ids[0]]

  instance_types = ["g6.xlarge"]
  capacity_type  = "SPOT"
  disk_size      = 100
  
  # GPU 인스턴스이므로 GPU 최적화 AMI 사용
  ami_type       = "AL2_x86_64_GPU" 

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1 # 스팟 인스턴스 비용 절감을 위해 필요 없을 시 0으로 조정 가능
  }

  labels = {
    nodegroup = "ai"
  }

  # 테인트(Taint) 설정
  taint {
    key    = "gpu"
    value  = "true"
    effect = "NO_SCHEDULE"
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.eks_ecr_read_only,
  ]
}