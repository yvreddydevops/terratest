resource "aws_lb" "my-elb" {
  name = "my-elb"
  internal = false
  load_balancer_type = "application"
  subnets = var.subnets_ex
  security_groups = [
    aws_security_group.allow-ssh.id]
  enable_deletion_protection = false
}
  resource "aws_lb_listener" "front_end" {
    load_balancer_arn = aws_lb.my-elb.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
      type             = "forward"
      target_group_arn = aws_lb_target_group.test.arn
    }
  }

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }

  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 400
  tags = {
    Name = "my-elb"
  }
}