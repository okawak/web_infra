variable "domain" {
  description = "The domain name to use."
  type        = string
}

variable "host_zone_id" {
  description = "The ID of the existing Route 53 hosted zone"
  type        = string
}
