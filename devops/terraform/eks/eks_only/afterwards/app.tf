terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.6.1"
    }
  }
  required_version = ">= 0.13"
}

data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "terraform-yossi-state"
    key    = "global/s3/terraform.tfstate"
    region = "eu-west-3"
  }
}

provider "kubernetes" {
  host                   = data.terraform_remote_state.eks.outputs.cluster_endpoint
  cluster_ca_certificate = base64decode(data.terraform_remote_state.eks.outputs.cluster_certificate_auth)
  token                  = data.terraform_remote_state.eks.outputs.eks_token
}

resource "kubernetes_manifest" "argo_app" {
  manifest = yamldecode(file("./app.yaml"))
}