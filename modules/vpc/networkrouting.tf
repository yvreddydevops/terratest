######## IGW ###############
resource "aws_internet_gateway" "main-igw" {
  vpc_id = aws_vpc.msk_vpc.id

  tags = {
    Name = "IGW"
  }
}



############# Route Tables public ##########

resource "aws_route_table" "PublicRouteTable" {
  vpc_id = aws_vpc.msk_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-igw.id
  }
  tags = {
    Name = "Public_routetable"
  }

}

/*
########### NAT ##############
resource "aws_eip" "nat" {
  count = length(aws_subnet.private_subnet)
}

resource "aws_nat_gateway" "main-natgw" {
  count = length(aws_subnet.private_subnet)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id = element(aws_subnet.public_subnet.*.id, count.index )

  tags = {
    Name =  format("%s--%s","gw NAT", count.index )
  }
}

############# Route Tables private ##########
resource "aws_route_table" "PrivateRouteTable" {
  count = length(aws_subnet.private_subnet)
  vpc_id = aws_vpc.msk_vpc.id
  route {

    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main-natgw[count.index].id
  }
    tags = {
      Name =  format("%s--%s","PRI RT", count.index )
}
}
*/
#########Route Table Association #############

resource "aws_route_table_association" "route_Publicsubnet" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.PublicRouteTable.id
}

/*
resource "aws_route_table_association" "route_Privatesubnet" {
  count          = length(var.private_subnet_cidrs)
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index)
  route_table_id = aws_route_table.PrivateRouteTable[count.index].id
}
*/


