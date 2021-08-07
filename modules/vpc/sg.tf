
resource "aws_security_group" "Bastion_SG" {
  name        = "Bastion_SG"
  description = "Allow TCP inbound traffic"
  vpc_id      = aws_vpc.msk_vpc.id

  ingress {
    description = "SSH port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TCP port"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Securitygoupd for Bastion"
  }
}


resource "aws_security_group" "ASG_SG" {
  name        = "ASG_SG"
  description = "Allow TCP inbound traffic"
  vpc_id      = aws_vpc.msk_vpc.id

  ingress {
    description = "SSH port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Securitygroup"
  }
}

output "security_groups" {
  value = aws_security_group.ASG_SG.id
}
