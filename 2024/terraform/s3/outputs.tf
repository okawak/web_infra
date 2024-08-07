output "bucket_name" {
  value = aws_s3_bucket.mydomain_bucket.bucket
}

output "domain_name" {
  value = aws_s3_bucket.mydomain_bucket.bucket_regional_domain_name
}

output "origin_id" {
  value = aws_s3_bucket.mydomain_bucket.id
}
