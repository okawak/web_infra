output "cloudfront_domain_name" {
  value = module.cloudfront.domain_name
}

output "alb_dns_name" {
  value = module.alb.dns_name
}

output "ec2_instance_public_ip" {
  value = module.ec2.instance_public_ip
}
