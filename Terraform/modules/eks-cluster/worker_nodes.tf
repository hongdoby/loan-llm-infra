# 1. Worker-1 노드 그룹 (Private-A 배치)
resource "aws_eks_node_group" "worker_1" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "worker-1"
  node_role_arn   = aws_iam_role.eks_node_role.arn

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

# 2. Worker-2 노드 그룹 (Private-C 배치)
resource "aws_eks_node_group" "worker_2" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "worker-2"
  node_role_arn   = aws_iam_role.eks_node_role.arn

  subnet_ids      = [var.subnet_ids[1]]

  instance_types = ["t3.large"]
  capacity_type  = "ON_DEMAND"
  disk_size      = 30

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