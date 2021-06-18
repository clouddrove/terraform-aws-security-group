#Module      : LABEL
#Description : Terraform label module variables.
variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "repository" {
  type        = string
  default     = "https://github.com/clouddrove/terraform-aws-security-group"
  description = "Terraform current module repo"
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "attributes" {
  type        = list(any)
  default     = []
  description = "Additional attributes (e.g. `1`)."
}

variable "managedby" {
  type        = string
  default     = "hello@clouddrove.com"
  description = "ManagedBy, eg 'CloudDrove'."
}

variable "label_order" {
  type        = list(any)
  default     = []
  description = "Label order, e.g. `name`,`application`."
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
  type        = list(any)
  default     = []
  description = "List of allowed ingress ports"
}

variable "allowed_ip" {
  type        = list(any)
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
  type        = list(any)
  default     = []
  description = "List of allowed ipv6."
}

variable "prefix_list" {
  type        = list(any)
  default     = []
  description = "List of prefix list IDs (for allowing access to VPC endpoints)Only valid with egress"
}

variable "is_external" {
  type        = bool
  default     = false
  description = "enable to udated existing security Group"
}

variable "existing_sg_id" {
  type        = string
  default     = null
  description = "Provide existing security group id for updating existing rule"
}

variable "prefix_list_ids" {
  type        = list(string)
  default     = []
  description = "Provide allow source Prefix id of resources"
}

##########################33
# egress Rules parameters

variable "egress_rule" {
  type        = bool
  default     = false
  description = "Enable to create egress rule"
}

variable "egress_allowed_ports" {
  type        = list(any)
  default     = []
  description = "List of allowed ingress ports"
}

variable "egress_allowed_ip" {
  type        = list(any)
  default     = []
  description = "List of allowed ip."
}

variable "egress_protocol" {
  type        = string
  default     = "tcp"
  description = "The protocol. If not icmp, tcp, udp, or all use the."
}

variable "egress_security_groups" {
  type        = list(string)
  default     = []
  description = "List of Security Group IDs allowed to connect to the instance."
}

variable "egress_allowed_ipv6" {
  type        = list(any)
  default     = []
  description = "List of allowed ipv6."
}

variable "egress_prefix_list_ids" {
  type        = list(any)
  default     = []
  description = "List of prefix list IDs (for allowing access to VPC endpoints)Only valid with egress"
}
