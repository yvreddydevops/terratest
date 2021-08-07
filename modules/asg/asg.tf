
/*
resource "aws_launch_configuration" "example-launchconfig" {
  name_prefix     = "example-launchconfig"
  image_id        = var.ami_id
  instance_type   = "t2.micro"
  key_name        = var.key_name
  security_groups = [var.security_groups]
  }


resource "aws_autoscaling_group" "example-autoscaling" {
  name                      = "example-autoscaling"
  vpc_zone_identifier       = var.public_subnet1
  launch_configuration      = aws_launch_configuration.example-launchconfig.name
  min_size                  = 2
  max_size                  = 2
  desired_capacity          = 2
  health_check_grace_period = 300
  health_check_type         = "EC2"
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "ec2 instance"
    propagate_at_launch = true
  }
}

*/

#data "aws_availability_zones" "available" {}

resource "aws_launch_template" "mylaunch_template" {
  name = "Launch_Template"
  image_id = var.ami_id
  instance_type = "t2.micro"
  key_name = "learnlinux"
  vpc_security_group_ids = [var.security_groups]
  tags = {
    Name = "Launch Template"
  }
}
resource "aws_autoscaling_group" "asg" {
  vpc_zone_identifier = var.public_subnet1
  desired_capacity   = 2
  max_size           = 2
  min_size           = 2

  launch_template {
    id      = aws_launch_template.mylaunch_template.id
   }
}

