#Module      : LABEL
#Description : Terraform label module variables.
variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "repository" {
  type        = string
  default     = ""
  description = "Terraform current module repo"

  validation {
    # regex(...) fails if it cannot find a match
    condition     = can(regex("^https://", var.repository))
    error_message = "The module-repo value must be a valid Git repo link."
  }
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "managedby" {
  type        = string
  default     = "hello@clouddrove.com"
  description = "ManagedBy, eg 'CloudDrove'."
}

variable "label_order" {
  type        = list
  default     = []
  description = "Label order, e.g. `name`,`application`."
}

variable "attributes" {
  type        = list
  default     = []
  description = "Additional attributes (e.g. `1`)."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)."
}

# Module      : SECURITY GROUP
# Description : Terraform security group module variables.
variable "enable_security_group" {
  type        = bool
  default     = true
  description = "Enable default Security Group with only Egress traffic allowed."
}

variable "vpc_id" {
  type        = string
  default     = ""
  description = "The ID of the VPC that the instance security group belongs to."
  sensitive   = true
}

variable "description" {
  type        = string
  default     = "Instance default security group (only egress access is allowed)."
  description = "The security group description."
}

variable "allowed_ports" {
  type        = list
  default     = []
  description = "List of allowed ingress ports"
}

variable "allowed_ip" {
  type        = list
  default     = []
  description = "List of allowed ip."
}

variable "security_groups" {
  type        = list(string)
  default     = []
  description = "List of Security Group IDs allowed to connect to the instance."
}

variable "protocol" {
  type        = string
  default     = "tcp"
  description = "The protocol. If not icmp, tcp, udp, or all use the."
}
variable "allowed_ipv6" {
  type        = list
  default     = []
  description = "List of allowed ipv6."
}
variable "prefix_list" {
  type        = list
  default     = []
  description = "List of prefix list IDs (for allowing access to VPC endpoints)Only valid with egress"

}