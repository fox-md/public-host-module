variable "vpc_id" {
  type = string
}

variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Instance type"
}

variable "ubuntu_version" {
  type        = string
  default     = "22.04"
  description = "Ubuntu OS version"

  validation {
    condition     = contains(["22.04", "20.04"], var.ubuntu_version)
    error_message = "The ubuntu_version must be either 'Windows' or 'Linux'."
  }
}

variable "domain_name" {
  type    = string
  default = null
}

variable "name" {
  type    = string
  default = null
}

variable "key_name" {
  type        = string
  description = "Name of SSH key"
}

variable "ingress_rules" {
  default = {}
}

variable "egress_rules" {
  default = {}
}

variable "create_dns_record" {
  type        = bool
  default     = true
  description = "Toggle to create A record"
}

variable "volume_size" {
  type        = number
  default     = 8
  description = "EBS volume size (Gb)"
}
