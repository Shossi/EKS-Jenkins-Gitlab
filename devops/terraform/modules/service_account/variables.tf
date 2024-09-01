variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "namespace" {
  description = "The Kubernetes namespace where the service account will be created"
  type        = string
  default     = "kube-system"
}

variable "oidc_provider_url" {
  description = "The OIDC provider URL for the EKS cluster"
  type        = string
}

variable "policy_name" {
  description = "Name of the IAM policy for the Cluster Autoscaler"
  type        = string
  default     = "cluster-autoscaler-policy"
}

variable "role_name" {
  description = "Name of the IAM role for the Cluster Autoscaler"
  type        = string
  default     = "cluster-autoscaler-role"
}
