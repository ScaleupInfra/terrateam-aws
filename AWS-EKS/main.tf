locals {
  name   = "infraSity"
  region = "us-east-1"

  tags = {
    created_by = "infraSity"
    terraform = "true"
    environment = "test"
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "eks-vpc"
  cidr = "10.0.0.0/16"

  azs = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false
  map_public_ip_on_launch = true
  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
module "eks" {
  source = "terraform-aws-modules/eks/aws"
  version = "~> 18.0"
  enable_irsa = false

  cluster_name = "eks-cluster"
  cluster_version = "1.27"

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access = true
  vpc_id = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets
  eks_managed_node_groups = {
    green = {
      min_size = 2
      max_size = 3
      desired_size = 2

      instance_types = ["t3.medium"]
      capacity_type = "SPOT"
    }
  }
  manage_aws_auth_configmap = false
}


resource "aws_security_group_rule" "allow_http" {
  type        = "ingress"
  from_port   = 8000
  to_port     = 8000
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]  
  security_group_id = module.eks.node_security_group_id
}
