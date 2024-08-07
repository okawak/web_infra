variable "domain" {
  description = "The domain name to use."
  type        = string
}

variable "acm_certificate_arn" {
  description = "The ARN of the ACM certificate to use for CloudFront."
}

variable "s3_domain_name" {
  description = "domain name of s3 bucket"
}

variable "s3_origin_id" {
  description = "S3 origin id"
}

variable "alb_dns_name" {
  description = "ALB DNS nane"
}

variable "alb_origin_id" {
  description = "ALB origin ID"
}

variable "random_name" {
  description = "random name for header"
}

variable "random_value" {
  description = "random value for header"
}
