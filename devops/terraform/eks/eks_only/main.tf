module "k8s" {
  source = "../"

  cluster_name = "my-cluster"
  subnet_ids   = [module.prod_network.private_subnets[0], module.prod_network.private_subnets[1]]
  vpc_id       = module.prod_network.vpc_id
}
module "prod_network" {
  source          = "../../network"
  vpc_name        = "prod-network"
  private_subnets = ["10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.102.0/24", "10.0.103.0/24"]
  azs             = ["eu-west-3b", "eu-west-3c"]
}

