module "dev_network" {
  source          = "../modules/network"
  vpc_name        = "dev-network"
  private_subnets = ["10.0.201.0/24"]
  public_subnets  = ["10.0.10.0/24", "10.0.11.0/24"]
  azs             = ["eu-west-3a", "eu-west-3b"]
}

module "default_sg" {
  source = "../modules/security_groups"

  name        = "default-sg"
  description = "Default security group"
  vpc_id      = module.dev_network.vpc_id
  ingress_rules = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  extra_ingress_rules = [
    {
      from_port        = 8080
      to_port          = 8080
      protocol         = "tcp"
      security_groups  = [module.lb.lb_sg_id]
      cidr_blocks      = []
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      self             = false
    },
    {
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      security_groups  = [module.bastion_sg.security_group_id]
      cidr_blocks      = []
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      self             = false
    },
    {
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      security_groups  = []
      cidr_blocks      = [module.dev_network.private_subnet_cidr]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      self             = false
    }
  ]
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  tags = {
    Name = "default-sg"
  }
}

module "bastion_sg" {
  source = "../modules/security_groups"

  name        = "bastion-sg"
  description = "Bastion security group"
  vpc_id      = module.dev_network.vpc_id
  ingress_rules = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["${chomp(data.http.ip.response_body)}/32"]
    }
  ]
  egress_rules = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  ]
  tags = {
    Name = "bastion-sg"
  }
}
