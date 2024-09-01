variable "ami" {}

variable "instance_type" {}

variable "sec_group_id" {}

variable "subnet_id" {}

variable "instance_name" {}

variable "key_name" {}

variable "iam_instance_profile" {
  description = "The IAM instance profile"
  type        = string
  default     = null
}