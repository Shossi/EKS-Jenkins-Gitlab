//noinspection MissingModule
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name                    = var.cluster_name
  cluster_version                 = "1.30"
  cluster_endpoint_private_access = var.cluster_endpoint_private_access
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access
  vpc_id                          = var.vpc_id
  subnet_ids                      = var.subnet_ids
  enable_irsa                     = var.enable_irsa

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
    Amazon-CloudWatch-Observability-agent = {
      most_recent = true
    }
  }

  eks_managed_node_groups = length(var.node_groups) > 0 ? var.node_groups : {}

  fargate_profiles = length(var.fargate_profiles) > 0 ? var.fargate_profiles : {}

  tags = var.eks_tags
}
