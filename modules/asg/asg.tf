

terraform {
  required_version = ">= 0.13"
}

resource "aws_security_group" "asg_security_group" {
  vpc_id      = var.vpc_id
  name        = "asg_security_group"
  description = "security group that allows ssh and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.asg_cidr]
  }
  tags = {
    Name = "asg-security-group"
  }
}

resource "aws_launch_template" "mylaunch_template" {
  name_prefix = "Launch_Template"

  image_id = var.ami_id
  instance_type = var.instance_type // "t2.micro"
  key_name = var.PATH_TO_PRIVATE_KEY
  vpc_security_group_ids = [aws_security_group.asg_security_group.id]
  user_data = var.user_data
  tags = {
    Name = "Launch Template"
  }
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_autoscaling_group" "asg_launch_tmpl" {
  name_prefix = aws_launch_template.mylaunch_template.name
  vpc_zone_identifier       = toset(var.autoscaling_subnets)
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = 2
  health_check_grace_period = 300
  health_check_type         = var.health_check_type // "EC2"
  force_delete              = true

  launch_template {
    id      = aws_launch_template.mylaunch_template.id
    version = aws_launch_template.mylaunch_template.latest_version
  }

  tag {
    key                 = "Name"
    value               = var.autoscale_name
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_attachment" "asg_attachemnt" {

  count = var.health_check_type == "ELB" ? 1 : 0
  autoscaling_group_name = aws_autoscaling_group.asg_launch_tmpl.id
  alb_target_group_arn = var.alb_target_grp_arn

}











