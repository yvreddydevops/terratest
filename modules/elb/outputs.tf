output "lb_dns_address" {
  value = aws_lb.my-elb.dns_name
}

output "lb_tgt_arn" {
  value = aws_lb_target_group.test.arn
}

output "lb_sec_group" {
  value = aws_security_group.allow-ssh.id
}