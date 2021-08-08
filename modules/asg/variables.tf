variable "ami_id" {}

variable "launch_config" {
  default = false
}

#variable "private_subnet" {}
variable "autoscaling_subnets" {
  type = set(string)
}
variable "aws_region" {
}

variable "key_name" {
}

variable "min_size" {}

variable "max_size" {}
variable "health_check_type" {
  default = "EC2"
}

variable "instance_type" {
  default = "t2.micro"
}

provider "aws" {
  region  = var.aws_region
}
variable "autoscale_name" {}
variable "security_groups" {
}