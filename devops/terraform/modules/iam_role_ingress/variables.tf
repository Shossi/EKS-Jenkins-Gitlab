################################################################################
# General Variables from root module
################################################################################

variable "main-region" {
  type = string
}

variable "env_name" {
  type = string
}

variable "cluster_name" {
  type = string
}

################################################################################
# Variables from other Modules
################################################################################

variable "oidc_provider_arn" {
  description = "OIDC Provider ARN used for IRSA "
  type        = string
}