resource "aws_vpc" "msk_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "MSK_VPC"
  }
}

resource "aws_internet_gateway" "main-igw" {
  vpc_id = aws_vpc.msk_vpc.id

  tags = {
    Name = "IGW"
  }
}


