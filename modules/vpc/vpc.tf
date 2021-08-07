
resource "aws_vpc" "msk_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "MSK_VPC"
  }
}
