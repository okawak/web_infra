# EC2 instance information
variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "ec2_ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "ec2_instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
}

variable "host_zone_id" {
  description = "The ID of the existing Route 53 hosted zone"
  type        = string
}

variable "route53_domain_name" {
  description = "domain name for the EC2 instance"
  type        = string
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key for Terraform to create EC2 instance"
  type        = string
}
