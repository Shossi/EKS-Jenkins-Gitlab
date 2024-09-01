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
  }
  required_version = "."
  backend "s3" {
    bucket  = "terraform-yossi-state"
    key     = "global/s3/terraform.tfstate"
    region  = "eu-west-3"
    encrypt = true
  }
}
provider "aws" {
  region = "eu-west-3"
}

provider "helm" {
  kubernetes {
    host                   = module.k8s.eks_cluster_endpoint
    cluster_ca_certificate = base64decode(module.k8s.cluster_auth)
    token                  = data.aws_eks_cluster_auth.this.token
  }
}

provider "kubernetes" {
  host                   = module.k8s.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(module.k8s.cluster_auth)
  token                  = data.aws_eks_cluster_auth.this.token
}

data "http" "ip" {
  url = "https://ipv4.icanhazip.com"
}

variable "public_key_path" {
  description = "Path to the SSH public key"
  type        = string
  default     = "/home/yossi/.ssh/new_key.pub"
}

data "aws_eks_cluster_auth" "this" {
  name = module.k8s.cluster_name
}