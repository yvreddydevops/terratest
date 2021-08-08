# Internet VPC
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"
  tags = {
    Name = "main"
  }
}
data "aws_availability_zones" "available" {}

# Subnets

resource "aws_subnet" "main-public-subnets" {
  vpc_id                  = aws_vpc.main.id
  count                   = length(var.cidr_block)
  cidr_block              =  element(values(var.cidr_block), count.index )
  map_public_ip_on_launch = "true"
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name =  format("%s--%s","main-pub-sub", count.index )
  }
}

output "subnets_ex" {
  value = aws_subnet.main-public-subnets.*.id
}

resource "aws_subnet" "main-private" {
  vpc_id                  = aws_vpc.main.id
  count                   = length(var.cidr_block_pri)
  cidr_block              =  element(values(var.cidr_block_pri), count.index )
#  map_public_ip_on_launch = "true"
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name =  format("%s--%s","main-pri-sub", count.index )
  }
}

# Internet GW
resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "main"
  }
}

# route tables
resource "aws_route_table" "main-public" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-gw.id
  }

  tags = {
    Name = "main-public-1"
  }
}

# route associations public
resource "aws_route_table_association" "main-public_rt" {
  count = length(var.cidr_block)
  subnet_id      = element(aws_subnet.main-public-subnets.*.id, count.index)
  route_table_id = aws_route_table.main-public.id
}

