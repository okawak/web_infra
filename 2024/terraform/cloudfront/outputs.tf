output "domain_name" {
  value = aws_cloudfront_distribution.main.domain_name
}

output "zone_id" {
  value = aws_cloudfront_distribution.main.hosted_zone_id
}

output "cloudfront_arn" {
  value = aws_cloudfront_distribution.main.arn
}
