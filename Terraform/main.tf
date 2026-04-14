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