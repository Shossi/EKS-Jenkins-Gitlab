resource "aws_instance" "instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.sec_group_id]
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  iam_instance_profile   = var.iam_instance_profile
  tags = {
    Name = var.instance_name
  }

#  user_data = <<-EOF
#              #!/bin/bash
#              sudo apt-get update -y
#              sudo apt install -y curl
#              curl https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb -o amazon-cloudwatch-agent.deb
#              sudo dpkg -i -E ./amazon-cloudwatch-agent.deb
#              # Create CloudWatch Agent configuration file
#              cat <<EOT > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json
#              ${file("../configurations/cloudwatch/cloudwatch-config.json")}
#              EOT
#              sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a start
#              EOF
}

