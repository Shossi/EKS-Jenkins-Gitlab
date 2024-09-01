//noinspection MissingModule
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  #  version = "5.0.0"

  name = var.vpc_name
  cidr = "10.0.0.0/16"

  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway     = true
  enable_vpn_gateway     = false
  one_nat_gateway_per_az = true

  enable_dns_hostnames = true
  enable_dns_support   = true
  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }
  map_public_ip_on_launch = "true"
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
