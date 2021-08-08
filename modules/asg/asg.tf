resource "aws_launch_configuration" "example-launchconfig" {

  count = var.launch_config ? 1 : 0
  name_prefix     = "example-launchconfig"
  image_id        = var.ami_id
  instance_type   = "t2.micro"
  key_name        = var.key_name
  security_groups = [var.security_groups]

  }


resource "aws_autoscaling_group" "example-autoscaling" {

  count = var.launch_config ? 1 : 0
  name                      = "example-autoscaling"
  vpc_zone_identifier       = toset(var.autoscaling_subnets)
  launch_configuration      = aws_launch_configuration.example-launchconfig[0].name
  min_size                  = var.min_size
  max_size                  = var.max_size
  desired_capacity          = 2
  health_check_grace_period = 300
  health_check_type         = var.health_check_type // "EC2"
  force_delete              = true

  tag {
    key                 = "Name"
    value               = var.autoscale_name
    propagate_at_launch = true
  }
}



#data "aws_availability_zones" "available" {}

resource "aws_launch_template" "mylaunch_template" {
  count = var.launch_config ? 0 : 1
  name_prefix = "Launch_Template"
  image_id = var.ami_id
  instance_type = var.instance_type // "t2.micro"
  key_name = "learnlinux"
  vpc_security_group_ids = [var.security_groups]
  tags = {
    Name = "Launch Template"
  }
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_autoscaling_group" "asg_launch_tmpl" {
  count = var.launch_config ?  0 : 1
  name_prefix = aws_launch_template.mylaunch_template[0].name
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
}

