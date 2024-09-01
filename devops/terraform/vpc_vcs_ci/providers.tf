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
  required_version = ">= 0.13"
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


data "http" "ip" {
  url = "https://ipv4.icanhazip.com"
}

variable "public_key_path" {
  description = "Path to the SSH public key"
  type        = string
  default     = "/home/yossi/.ssh/new_key.pub"
}
