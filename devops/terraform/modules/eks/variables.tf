variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_endpoint_private_access" {
  description = "Enable private access to the cluster endpoint"
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access" {
  description = "Enable public access to the cluster endpoint"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "enable_irsa" {
  description = "Enable IAM Roles for Service Accounts (IRSA)"
  type        = bool
  default     = true
}

variable "eks_tags" {
  description = "Tags for the EKS cluster"
  type        = map(string)
  default = {
    Environment = "prod"
  }
}

variable "node_groups" {
  description = "Map of managed node groups"
  type        = map(any)
}

variable "fargate_profiles" {
  description = "Map of Fargate profiles"
  type        = map(any)
}