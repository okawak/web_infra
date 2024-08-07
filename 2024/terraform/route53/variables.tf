variable "domain" {
  description = "The domain name to use."
  type        = string
}

variable "host_zone_id" {
  description = "The ID of the existing Route 53 hosted zone"
  type        = string
}

variable "cloudfront_zone_id" {
  description = "zone id of cloudfront"
}

variable "cloudfront_domain_name" {
  description = "The CloudFront domain name to use."
}

variable "alb_zone_id" {
  description = "zone id of ALB"
}

variable "alb_dns_name" {
  description = "The ALB DNS name to use."
}
