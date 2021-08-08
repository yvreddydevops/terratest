aws_region  = "eu-west-2"
environment = "Prod"
application = "acm"
aws-profile = "prod"

vpc_cidr             = "192.168.0.0/16"
private_subnet_cidrs =["192.168.8.0/24", "192.168.10.0/24", "192.168.12.0/24"]
public_subnet_cidrs  = ["192.168.9.0/24", "192.168.11.0/24", "192.168.13.0/24"]