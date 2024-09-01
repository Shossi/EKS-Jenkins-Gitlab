resource "aws_lb" "main" {
  name               = var.load_balancer_name
  internal           = var.internal
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = var.public_subnets
  enable_deletion_protection = false

  tags = var.tags
}

resource "aws_security_group" "lb_sg" {
  name   = "${var.load_balancer_name}-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_lb_target_group" "jenkins_tg" {
  name        = "${var.load_balancer_name}-jenkins-tg"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = var.tags
}

resource "aws_lb_target_group" "gitlab_tg" {
  name        = "${var.load_balancer_name}-gitlab-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = var.tags
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jenkins_tg.arn
  }
}

resource "aws_lb_listener" "gitlab_listener" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.gitlab_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "jenkins_targets" {
  count            = length(var.jenkins_instance_ids)
  target_group_arn = aws_lb_target_group.jenkins_tg.arn
  target_id        = element(var.jenkins_instance_ids, count.index)
  port             = 8080
}

resource "aws_lb_target_group_attachment" "gitlab_target" {
  target_group_arn = aws_lb_target_group.gitlab_tg.arn
  target_id        = var.gitlab_instance_id
  port             = 80
}

