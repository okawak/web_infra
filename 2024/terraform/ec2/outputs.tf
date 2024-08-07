output "instance_id" {
  value = aws_instance.vps_home.id
}

output "instance_public_ip" {
  value = aws_eip.ec2_eip.public_ip
}
