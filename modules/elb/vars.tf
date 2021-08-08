variable "AWS_REGION" {
  default = "eu-west-2"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-13be557e"
    us-west-2 = "ami-06b94666"
    eu-west-2 = "ami-06178cf087598769c"
  }
}
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