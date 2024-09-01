variable "role_name" {
  description = "The name of the IAM role"
  type        = string
  default     = "jenkins-agent-role"
}

variable "eks_instance_profile_name" {
  description = "The name of the IAM instance profile"
  type        = string
  default     = "jenkins-agent-instance-profile"
}

variable "cloudwatch_role_name" {
  description = "The name of the IAM role"
  type        = string
  default     = "Cloudwatch-agent-role"
}

variable "cloudwatch_instance_profile_name" {
  description = "The name of the IAM instance profile"
  type        = string
  default     = "CloudWatch-agent-instance-profile"
}