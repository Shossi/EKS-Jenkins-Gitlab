
module "jenkins_agent" {
  source               = "../modules/instance"
  ami                  = "ami-094bf9188e8ea6c60"
  instance_type        = "t2.micro"
  sec_group_id         = module.default_sg.security_group_id
  subnet_id            = module.dev_network.private_subnets[0]
  key_name             = aws_key_pair.deployer.key_name
  instance_name        = "jenkins-agent"
  iam_instance_profile = module.jenkins_agent_iam_role.jenkins_agent_instance_profile_name
}

module "jenkins" {
  source = "../modules/instance"

  ami           = "ami-0912a08e0ad10580b"
  instance_type = "t3.large"
  sec_group_id  = module.default_sg.security_group_id
  subnet_id     = module.dev_network.private_subnets[0]
  instance_name = "jenkins-controller"
  key_name      = aws_key_pair.deployer.key_name
}

module "gitlab" {
  source = "../modules/instance"

  ami           = "ami-052c9873836ea503c"
  instance_type = "t3.large"
  sec_group_id  = module.default_sg.security_group_id
  subnet_id     = module.dev_network.private_subnets[0]
  instance_name = "gitlab"
  key_name      = aws_key_pair.deployer.key_name
}

module "bastion" {
  source = "../modules/instance"

  ami           = "ami-0326f9264af7e51e2"
  instance_type = "t2.micro"
  sec_group_id  = module.bastion_sg.security_group_id
  subnet_id     = module.dev_network.public_subnets[0]
  instance_name = "bastion-host"
  key_name      = aws_key_pair.deployer.key_name
}


module "lb" {
  source = "../modules/lb"

  vpc_id               = module.dev_network.vpc_id
  public_subnets       = module.dev_network.public_subnets
  internal             = false
  load_balancer_name   = "my-alb"
  jenkins_instance_ids = [module.jenkins.instance_id]
  gitlab_instance_id   = module.gitlab.instance_id
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
  source                           = "../modules/roles"
  cloudwatch_instance_profile_name = "bozowatch"
  cloudwatch_role_name             = "bozowatch_role"
}
