output "certificate_cloudfront_arn" {
  value = aws_acm_certificate.mydomain_cloudfront.arn
}
