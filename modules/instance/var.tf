variable "ami_id" {}
variable "key_name" {}

variable "subnet_id" {
 type = list
}

variable "vpc_cidr" {
}
variable "msk_vpc" {
}
variable "security_group_id" {}
variable "aws_region" {}

variable "numberofservers" {
 }
