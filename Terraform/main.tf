module "network" {
  source = "./modules/network"

  vpc_cidr               = var.vpc_cidr
  cluster_name           = var.cluster_name
  azs                    = var.azs

  public_subnet_2a_cidr  = var.public_subnet_2a_cidr
  public_subnet_2c_cidr  = var.public_subnet_2c_cidr
  private_subnet_2a_cidr = var.private_subnet_2a_cidr
  private_subnet_2c_cidr = var.private_subnet_2c_cidr
}

module "eks_cluster" {
  source = "./modules/eks-cluster"

  cluster_name = var.cluster_name
  
  # network 모듈에서 생성된 프라이빗 서브넷 ID를 배열 형태로 전달
  subnet_ids   = [
    module.network.private_subnet_2a_id,
    module.network.private_subnet_2c_id,
   ]
   
   admin_users  = var.admin_users
}