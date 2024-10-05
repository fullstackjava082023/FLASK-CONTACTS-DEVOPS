provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-demo-vpc"
  cidr = "10.10.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.10.1.0/24", "10.10.2.0/24"]
  public_subnets  = ["10.10.101.0/24", "10.10.102.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

#   enable_vpn_gateway = true


  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}


# EKS Module
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "my-terra-cluster"
  cluster_version = "1.31"
  subnet_ids         = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.public_subnets
  vpc_id          = module.vpc.vpc_id


  cluster_endpoint_public_access = true
  cluster_endpoint_private_access = true

  eks_managed_node_groups  = {
    terra-eks = {
        min_size = 1
        max_size = 2
        desired_size = 2
        
        instance_types = ["t3.small"]
    }

  }

  # Cluster access entry
  # To add the current caller identity as an administrator
  enable_cluster_creator_admin_permissions = true
  tags = {
    Environment = "dev"
    Terraform   = "true"
  }

  authentication_mode = "API_AND_CONFIG_MAP"
}

# # Output the cluster kubeconfig
# output "kubeconfig" {
#   value = module.eks.kubeconfig
# }

# Output the cluster endpoint
output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

# Output the cluster kubeconfig command
output "kubeconfig_command" {
  value = "aws eks update-kubeconfig --name ${module.eks.cluster_name} --region us-east-1"
}