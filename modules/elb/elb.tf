provider "aws" {
  region = var.AWS_REGION
}

terraform {
  required_version = ">= 0.13"
}
#dns address.
resource "aws_lb" "my-elb" {
  name = "my-elb"
  internal = false
  load_balancer_type = "application"
  subnets = var.subnets_ex
  security_groups = [aws_security_group.allow-ssh.id]
  enable_deletion_protection = false
}

#target group name arn.
resource "aws_lb_target_group" "test" {
  name     = "lb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "front_end" {
    load_balancer_arn = aws_lb.my-elb.arn
    port              = "80"
    protocol          = "HTTP"
    default_action {
      type             = "forward"
      target_group_arn = aws_lb_target_group.test.arn # This is what is linking alb to target group.
    }
}

resource "aws_lb_listener_rule" "static" {
  listener_arn = aws_lb_listener.front_end.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test.arn
  }

  condition {
    path_pattern {
      values = ["*/*"]
    }
  }
}
