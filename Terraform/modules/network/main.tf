# VPC1
resource "aws_vpc" "vpc1" {
  cidr_block           = var.vpc_cidr  # "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "vpc1-loan-llm"
  }
}

# igw
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "vpc1-igw"
  }
}

# public subnet (ALB, NAT 게이트웨이용)
resource "aws_subnet" "public_2a" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = var.public_subnet_2a_cidr  # "10.0.0.0/22"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name                                     = "vpc1-public-2a"
    "kubernetes.io/role/elb"                 = "1"
    "kubernetes.io/cluster/loan-llm-cluster" = "shared"
  }
}

resource "aws_subnet" "public_2c" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = var.public_subnet_2c_cidr  # "10.0.4.0/22"
  availability_zone       = "ap-northeast-2c"
  map_public_ip_on_launch = true

  tags = {
    Name                                     = "vpc1-public-2c"
    "kubernetes.io/role/elb"                 = "1"
    "kubernetes.io/cluster/loan-llm-cluster" = "shared"
  }
}

# private subnet(EKS 노드용)
resource "aws_subnet" "private_2a" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = var.private_subnet_2a_cidr  # "10.0.8.0/22"
  availability_zone = "ap-northeast-2a"

  tags = {
    Name                                     = "vpc1-private-2a"
    "kubernetes.io/role/internal-elb"        = "1"
    "kubernetes.io/cluster/loan-llm-cluster" = "shared"
  }
}

resource "aws_subnet" "private_2c" {
  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = var.private_subnet_2c_cidr  # "10.0.12.0/22"
  availability_zone = "ap-northeast-2c"

  tags = {
    Name                                     = "vpc1-private-2c"
    "kubernetes.io/role/internal-elb"        = "1"
    "kubernetes.io/cluster/loan-llm-cluster" = "shared"
  }
}

# NAT게이트웨이
resource "aws_eip" "nat_eip" {
  domain = "vpc"

  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "vpc1-nat-eip"  # ← 추가
  }
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_2a.id

  depends_on = [
    aws_internet_gateway.igw,
    aws_eip.nat_eip,
  ]

  tags = {
    Name = "vpc1-nat-gw"
  }
}

# 라우팅 테이블 public
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "vpc1-public-rt"
  }
}

resource "aws_route_table_association" "pub_2a" {
  subnet_id      = aws_subnet.public_2a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "pub_2c" {
  subnet_id      = aws_subnet.public_2c.id
  route_table_id = aws_route_table.public_rt.id
}

# 라우팅테이블 프라이빗 섭넷 넷 게이트웨이 통신용
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "vpc1-private-rt"
  }
}

resource "aws_route_table_association" "priv_2a" {
  subnet_id      = aws_subnet.private_2a.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "priv_2c" {
  subnet_id      = aws_subnet.private_2c.id
  route_table_id = aws_route_table.private_rt.id
}