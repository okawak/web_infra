provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

resource "aws_acm_certificate" "mydomain_cloudfront" {
  provider          = aws.us_east_1
  domain_name       = var.domain
  validation_method = "DNS"

  subject_alternative_names = ["*.${var.domain}"]

  tags = {
    Name = "mydomain-cloudfront-certificate"
  }
}

resource "aws_route53_record" "mydomain_cloudfront_validation" {
  for_each = {
    for dvo in aws_acm_certificate.mydomain_cloudfront.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id         = var.host_zone_id
  name            = each.value.name
  type            = each.value.type
  ttl             = 60
  records         = [each.value.record]
  allow_overwrite = true
}

resource "aws_acm_certificate_validation" "mydomain_cloudfront" {
  provider                = aws.us_east_1
  certificate_arn         = aws_acm_certificate.mydomain_cloudfront.arn
  validation_record_fqdns = [for record in aws_route53_record.mydomain_cloudfront_validation : record.fqdn]
}
