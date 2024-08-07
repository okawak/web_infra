variable "tenancy_ocid" {
  type        = string
  description = "tenancy ocid"
}

variable "user_ocid" {
  type        = string
  description = "user ocid"
}

variable "fingerprint" {
  type        = string
  description = "fingerprint"
}

variable "private_key_path" {
  type        = string
  description = "private key path for API"
}

variable "region" {
  type        = string
  description = "OCI region"
}

variable "ssh_public_key_path" {
  type        = string
  description = "ssh public key path"
}
