variable "create_default_security_group" {
  description = "Create default Security Group with only Egress traffic allowed"
  default     = "true"
}

variable "vpc_id" {
  description = "The ID of the VPC that the instance security group belongs to"
  default     = ""
}

variable "allowed_ports" {
  type        = "list"
  description = "List of allowed ingress ports"
  default     = []
}

variable "application" {
  type        = "string"
  description = "application (e.g. `cp` or `clouddrove`)"
}

variable "environment" {
  type        = "string"
  description = "Environment (e.g. `prod`, `dev`, `staging`)"
}

variable "name" {
  description = "Name  (e.g. `bastion` or `db`)"
}

variable "delimiter" {
  default     = "-"
  description = "Delimiter to be used between `name`, `namespace`, `stage`, etc."
}

variable "attributes" {
  description = "Additional attributes (e.g. `1`)"
  type        = "list"
  default     = []
}

variable "tags" {
  description = "Additional tags"
  type        = "map"
  default     = {}
}

variable "cidr_blocks" {
  description = "List of CIDR blocks"
  type        = "list"
  default     = []
}

variable "security_groups" {
  description = "List of Security Group IDs allowed to connect to the instance"
  type        = "list"
  default     = []
}
