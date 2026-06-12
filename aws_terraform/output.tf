output "ec2_public_ip" {
  value = [for i in aws_instance.myEC2 : i.public_ip]
}

output "ec2_public_dns" {
  value = [for i in aws_instance.myEC2 : i.public_dns]
}
