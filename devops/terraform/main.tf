module "prod_network" {
  source          = "./network"
  vpc_name        = "prod-network"
  private_subnets = ["10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.102.0/24", "10.0.103.0/24"]
  azs             = ["eu-west-3b", "eu-west-3c"]
}

module "dev_network" {
  source          = "./network"
  vpc_name        = "dev-network"
  private_subnets = ["10.0.101.0/24"]
  public_subnets  = ["10.0.1.0/24"]
  azs             = ["eu-west-3a"]
}

module "default_sg" {
  source = "./security_groups"

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
  source = "./security_groups"

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

module "jenkins_agent" {
  source = "./instance"
  ami                  = "ami-094bf9188e8ea6c60"
  instance_type        = "t2.micro"
  sec_group_id         = module.default_sg.security_group_id
  subnet_id            = module.dev_network.private_subnets
  key_name             = aws_key_pair.deployer.key_name
  instance_name        = "jenkins-agent"
  iam_instance_profile = module.jenkins_agent_iam_role.jenkins_agent_instance_profile_name
}

module "jenkins" {
  source = "./instance"

  ami            = "ami-0912a08e0ad10580b"
  instance_type  = "t3.large"
  sec_group_id   = module.default_sg.security_group_id
  subnet_id      = module.dev_network.private_subnets
  instance_name  = "jenkins-controller"
  key_name       = aws_key_pair.deployer.key_name
}

module "gitlab" {
  source = "./instance"

  ami            = "ami-052c9873836ea503c"
  instance_type  = "t3.large"
  sec_group_id   = module.default_sg.security_group_id
  subnet_id      = module.dev_network.private_subnets
  instance_name  = "gitlab"
  key_name       = aws_key_pair.deployer.key_name
}

module "bastion" {
  source = "./instance"

  ami            = "ami-0326f9264af7e51e2"
  instance_type  = "t2.micro"
  sec_group_id   = module.bastion_sg.security_group_id
  subnet_id      = module.dev_network.public_subnets
  instance_name  = "bastion-host"
  key_name       = aws_key_pair.deployer.key_name
}

module "k8s" {
  source = "./eks"

  cluster_name = "k8s-cluster"
  subnet_ids   = [module.prod_network.private_subnets[0], module.prod_network.private_subnets[1]]
  vpc_id       = module.prod_network.vpc_id
}

module "lb" {
  source = "./lb"

  vpc_id             = module.dev_network.vpc_id
  public_subnets     = module.dev_network.public_subnets
  internal           = false
  load_balancer_name = "my-alb"
  jenkins_instance_ids = [module.jenkins.instance_id]
  gitlab_instance_id = module.gitlab.instance_id
  tags = {
    Terraform   = "true"
    Environment = "prod"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file(var.public_key_path)
}

module "jenkins_agent_iam_role" {
  source = "./roles"
  cloudwatch_instance_profile_name = "bozowatch"
  cloudwatch_role_name = "bozowatch_role"
}

resource "aws_security_group_rule" "allow_eks_from_jenkins" {
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = module.k8s.cluster_security_group_id
  source_security_group_id = module.default_sg.security_group_id
}
