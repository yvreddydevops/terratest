data "aws_availability_zones" "available" {
}


resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.msk_vpc.id
  cidr_block        = length(var.private_subnet_cidrs) == 0 ? "" :  element(split(",", join(",", var.private_subnet_cidrs)), count.index)
  #var.private_subnet_cidrs[count.index] # element(var.private_subnet_cidrs, count.index ) #var.private_subnet_cidrs[count.index]  #element(split(",", join(",", var.private_subnet_cidrs)), count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

     tags = {
    Name =  format("%s--%s","Pri_sub", count.index )
  }
}



resource "aws_subnet" "public_subnet" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.msk_vpc.id
  cidr_block        = element(var.public_subnet_cidrs, count.index ) #element(split(",", join(",", var.public_subnet_cidrs)), count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name =  format("%s--%s","Pub_subnet", count.index )
  }

}


