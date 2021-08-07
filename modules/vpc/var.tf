# Standard Variables

variable "aws_region" {
  type    = string
  default = "eu-west-2"
}

variable "aws-profile" {
  description = "Local AWS Profile Name "
  type        = string
}

variable "environment" {
  description = "AWS Environment"
  type        = string
}

variable "application" {
  type    = string
  default = "acm"
}

# VPC Variables

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}
variable "private_subnet_cidrs" {
  description = "Private subnet  - CIDR"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "Private subnet  - CIDR"
  type        = list(string)
}


