variable "vpc_name" {
  type        = string
  description = "Name to be used on all the resources as identifier"
}
variable "public_subnets" {
  type        = list(string)
  description = "A list of public subnets inside the VPC"
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}
variable "private_subnets" {
  type        = list(string)
  description = "A list of private subnets inside the VPC"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
variable "azs" {
  type        = list(string)
  description = "A list of availability zones specified as argument to this module"
  default     = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
}