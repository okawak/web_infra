variable "vpc_id" {
  description = "The VPC ID to deploy the EC2 instance into."
}

variable "public_subnet" {
  description = "The public subnet to deploy the EC2 instance into."
}

variable "ec2_ami" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "ec2_instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
}

variable "key_name" {
  description = "The name of the SSH key pair to use for EC2 instances."
}
