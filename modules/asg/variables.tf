variable "ami_id" {}

#variable "private_subnet" {}
variable "public_subnet1" {
  type = set(string)
}
variable "aws_region" {
}

variable "key_name" {
}


provider "aws" {
  region  = var.aws_region
}
variable "security_groups" {
}