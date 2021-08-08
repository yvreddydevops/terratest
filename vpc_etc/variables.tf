variable "aws_region" {}

variable "aws-profile" {}

variable "environment" {}

variable "application" {}

# VPC Variables

variable "vpc_cidr" {}

variable "public_subnet_cidrs" {}
variable "private_subnet_cidrs" {}

variable "ami_id" {
default = "ami-0ad8ecac8af5fc52b"
}


variable "key_name" {
  default = "learnlinux"
}

#variable "user_data" {}
#variable "subnet_id" {}

#variable "msk_vpc" {}
#variable "security_sg" {}