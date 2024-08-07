resource "random_string" "name" {
  length  = 12
  upper   = false
  lower   = true
  special = false
}

resource "random_string" "value" {
  length  = 12
  upper   = false
  lower   = true
  special = false
}

module "vpc" {
  source = "./vpc"
}

module "acm_alb" {
  source       = "./acm/alb"
  domain       = var.route53_domain_name
  host_zone_id = var.host_zone_id
}

module "acm_cloudfront" {
  source       = "./acm/cloudfront"
  domain       = var.route53_domain_name
  host_zone_id = var.host_zone_id
}

module "ec2" {
  source            = "./ec2"
  vpc_id            = module.vpc.vpc_id
  public_subnet     = module.vpc.public_subnets[0]
  ec2_ami           = var.ec2_ami
  ec2_instance_type = var.ec2_instance_type
  key_name          = var.ssh_public_key_path
}

module "s3" {
  source         = "./s3"
  domain         = var.route53_domain_name
  cloudfront_arn = module.cloudfront.cloudfront_arn
}

module "alb" {
  source              = "./alb"
  domain              = var.route53_domain_name
  acm_certificate_arn = module.acm_alb.certificate_alb_arn
  vpc_id              = module.vpc.vpc_id
  subnets             = module.vpc.public_subnets
  instance_id         = module.ec2.instance_id
  random_name         = random_string.name.result
  random_value        = random_string.value.result
}

module "route53" {
  source                 = "./route53"
  domain                 = var.route53_domain_name
  host_zone_id           = var.host_zone_id
  cloudfront_zone_id     = module.cloudfront.zone_id
  cloudfront_domain_name = module.cloudfront.domain_name
  alb_zone_id            = module.alb.zone_id
  alb_dns_name           = module.alb.dns_name
}

module "cloudfront" {
  source              = "./cloudfront"
  domain              = var.route53_domain_name
  acm_certificate_arn = module.acm_cloudfront.certificate_cloudfront_arn
  s3_domain_name      = module.s3.domain_name
  s3_origin_id        = module.s3.origin_id
  alb_dns_name        = module.alb.dns_name
  alb_origin_id       = module.alb.alb_origin_id
  random_name         = random_string.name.result
  random_value        = random_string.value.result
}

module "gh-action" {
  source     = "./gh-action"
  account_id = "471112601703"
  gh-user    = "okawak"
  gh-repo    = "okawak_net"
  gh-branch  = "main"
}
