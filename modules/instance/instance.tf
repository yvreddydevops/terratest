
data "aws_availability_zones" "available" {}



resource "aws_instance" "Bastion_server" {
  count = var.numberofservers
  ami           = var.ami_id
  instance_type = "t2.micro"
  key_name = var.key_name
  associate_public_ip_address = true
  vpc_security_group_ids = [var.security_group_id]
  subnet_id = var.subnet_id[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "Bastion"
  }
}
