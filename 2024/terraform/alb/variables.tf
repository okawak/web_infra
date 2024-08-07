variable "domain" {
  description = "The domain name to use."
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID to deploy the ALB into."
}

variable "subnets" {
  description = "The subnets to deploy the ALB into."
  type        = list(string)
}

variable "acm_certificate_arn" {
  description = "The ARN of the ACM certificate to use for the ALB."
}

variable "instance_id" {
  description = "The EC2 instance id connected to ALB"
}

variable "random_name" {
  description = "random name for header"
  type        = string
}

variable "random_value" {
  description = "random value for header"
  type        = string
}
