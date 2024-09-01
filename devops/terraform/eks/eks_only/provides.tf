terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.5.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.6.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.6.1"
    }
  }
  required_version = ">= 0.13"
  backend "s3" {
    bucket         = "terraform-yossi-state"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-west-3"
    encrypt        = true
  }
}
provider "aws" {
  region = "eu-west-3"
}

provider "kubernetes" {
  host                   = module.k8s.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(module.k8s.cluster_auth)
  token                  = data.aws_eks_cluster_auth.this.token
}

provider "helm" {
  kubernetes {
    host                   = module.k8s.eks_cluster_endpoint
    cluster_ca_certificate = base64decode(module.k8s.cluster_auth)
    token                  = data.aws_eks_cluster_auth.this.token
  }
}


data "aws_eks_cluster_auth" "this" {
  name = module.k8s.cluster_name
}

resource "helm_release" "argocd" {
  depends_on = [module.k8s]
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "4.5.2"
  namespace = "argocd"
  create_namespace = true
  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }
  set {
    name  = "server.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
    value = "nlb"
  }
}
