resource "aws_vpc" "msk_vpc" {
  cidr_block = var.vpc_cidr

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


