
output "public_subnet_ids" {
  value = aws_subnet.public_subnet.*.id
}
output "pravite_subnet_id" {
  value = aws_subnet.private_subnet.*.id
}

output "msk_vpc_id" {
  value = aws_vpc.msk_vpc.id
}

output "Bastion_SG_id" {
  value = aws_security_group.Bastion_SG.id
}

