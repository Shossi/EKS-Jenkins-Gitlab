module "prod_network" {
  source          = "../modules/network"
  vpc_name        = "prod-network"
  private_subnets = ["10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.102.0/24", "10.0.103.0/24"]
  azs             = ["eu-west-3b", "eu-west-3c"]
}
