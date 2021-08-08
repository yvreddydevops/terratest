variable "AWS_REGION" {
  default = "eu-west-2"
}

variable "vpc_id" {}
variable "lb_port" {}



variable "subnets_ex" {
 type = set(string)
}

variable "cidr_block" {
  type = map(string)
  default = {
    eu-west-2a : "10.0.1.0/24",
    eu-west-2b : "10.0.2.0/24",
    eu-west-2c : "10.0.3.0/24"
  }
}

variable "cidr_block_pri" {
  type = map(string)
  default = {
    eu-west-2a : "10.0.4.0/24",
    eu-west-2b : "10.0.5.0/24",
    eu-west-2c : "10.0.6.0/24"
  }
}