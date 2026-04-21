# EBS CSI Driver 애드온 설치
resource "aws_eks_addon" "ebs_csi_driver" {
  cluster_name             = aws_eks_cluster.eks_cluster.name
  addon_name               = "aws-ebs-csi-driver"
  service_account_role_arn = aws_iam_role.ebs_csi_driver_role.arn

  # 노드가 뜬 다음에 설치되도록 의존성 부여
  depends_on = [
    aws_eks_node_group.worker_1,
    aws_eks_node_group.worker_2
  ]
}