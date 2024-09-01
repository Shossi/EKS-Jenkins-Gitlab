variable "vpc_id" {
  description = "The VPC ID where the load balancer will be deployed"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnets to deploy the load balancer"
  type        = list(string)
}

variable "internal" {
  description = "Whether the load balancer is internal"
  type        = bool
  default     = false
}

variable "load_balancer_name" {
  description = "Name of the load balancer"
  type        = string
}

variable "jenkins_instance_ids" {
  description = "List of Jenkins instance IDs"
  type        = list(string)
}

variable "tags" {
  description = "Tags to assign to the load balancer"
  type        = map(string)
}

variable "gitlab_instance_id" {
  description = "Gitlab instance ID"
  type = string
}
