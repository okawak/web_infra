resource "aws_route53_record" "www" {
  zone_id = var.host_zone_id
  name    = "www.${var.domain}"
  type    = "A"

  alias {
    name                   = var.cloudfront_domain_name
    zone_id                = var.cloudfront_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "alb" {
  zone_id = var.host_zone_id
  name    = "alb.${var.domain}"
  type    = "A"

  alias {
    name                   = var.alb_dns_name
    zone_id                = var.alb_zone_id
    evaluate_target_health = true
  }
}
