variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "label_order" {
  type        = list(any)
  default     = ["name", "environment"]
  description = "Label order, e.g. `name`,`application`."
}

variable "repository" {
  type        = string
  default     = "https://github.com/clouddrove/terraform-aws-security-group"
  description = "Terraform current module repo"
}

variable "managedby" {
  type        = string
  default     = "hello@clouddrove.com"
  description = "ManagedBy, eg 'CloudDrove'."
}

variable "vpc_id" {
  type        = string
  default     = ""
  description = "The ID of the VPC that the instance security group belongs to."
  sensitive   = true
}

variable "prefix_list_ids" {
  type        = list(string)
  default     = []
  description = "The ID of the prefix list."
}

variable "prefix_list_enabled" {
  type        = bool
  default     = true
  description = "Enable prefix_list."
}

variable "max_entries" {
  type        = number
  default     = 5
  description = "The maximum number of entries that this prefix list can contain."
}

variable "entry" {
  type        = list(any)
  default     = []
  description = "Can be specified multiple times for each prefix list entry."
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

variable "new_enable_security_group" {
  type        = bool
  default     = true
  description = "Enable default Security Group with only Egress traffic allowed."
}

variable "allowed_ipv6" {
  type        = list(any)
  default     = ["2405:201:5e00:3684:cd17:9397:5734:a167/128"]
  description = "List of allowed ipv6."
}

variable "egress_rule" {
  type        = bool
  default     = false
  description = "Enable to create egress rule"
}

variable "egress_allowed_ip" {
  type        = list(any)
  default     = []
  description = "List of allowed ip."
}

variable "egress_allowed_ports" {
  type        = list(any)
  default     = []
  description = "List of allowed ingress ports"
}

variable "egress_protocol" {
  type        = string
  default     = "tcp"
  description = "The protocol. If not icmp, tcp, udp, or all use the."
}

variable "egress_prefix_list_ids" {
  type        = list(any)
  default     = []
  description = "List of prefix list IDs (for allowing access to VPC endpoints)Only valid with egress"
}

variable "egress_security_groups" {
  type        = list(string)
  default     = []
  description = "List of Security Group IDs allowed to connect to the instance."
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

variable "new_sg_ingress_rules_with_cidr_blocks" {
  type        = any
  default     = {}
  description = "Ingress rules for security group. Should be used when new security group is been deployed."
}

variable "new_sg_ingress_rules_with_self" {
  type        = any
  default     = {}
  description = "Ingress rules for security group. Should be used when new security group is been deployed."
}

variable "new_sg_ingress_rules_with_source_sg_id" {
  type        = any
  default     = {}
  description = "Ingress rules for security group. Should be used when new security group is been deployed."
}

variable "new_sg_ingress_rules_with_prefix_list" {
  type        = any
  default     = {}
  description = "Ingress rules for security group. Should be used when new security group is been deployed."
}

variable "existing_sg_ingress_rules_with_cidr_blocks" {
  type        = any
  default     = {}
  description = "Ingress rules for security group. Should be used when new security group is been deployed."
}

variable "existing_sg_ingress_rules_with_self" {
  type        = any
  default     = {}
  description = "Ingress rules for security group. Should be used when new security group is been deployed."
}

variable "existing_sg_ingress_rules_with_source_sg_id" {
  type        = any
  default     = {}
  description = "Ingress rules for security group. Should be used when new security group is been deployed."
}

variable "existing_sg_ingress_rules_with_prefix_list" {
  type        = any
  default     = {}
  description = "Ingress rules for security group. Should be used when new security group is been deployed."
}

variable "new_sg_egress_rules_with_cidr_blocks" {
  type        = any
  default     = {}
  description = "Ingress rules for security group. Should be used when new security group is been deployed."
}

variable "new_sg_egress_rules_with_self" {
  type        = any
  default     = {}
  description = "Ingress rules for security group. Should be used when new security group is been deployed."
}

variable "new_sg_egress_rules_with_source_sg_id" {
  type        = any
  default     = {}
  description = "Ingress rules for security group. Should be used when new security group is been deployed."
}

variable "new_sg_egress_rules_with_prefix_list" {
  type        = any
  default     = {}
  description = "Ingress rules for security group. Should be used when new security group is been deployed."
}

variable "existing_sg_egress_rules_with_cidr_blocks" {
  type        = any
  default     = {}
  description = "Ingress rules for security group. Should be used when new security group is been deployed."
}

variable "existing_sg_egress_rules_with_self" {
  type        = any
  default     = {}
  description = "Ingress rules for security group. Should be used when new security group is been deployed."
}

variable "existing_sg_egress_rules_with_source_sg_id" {
  type        = any
  default     = {}
  description = "Ingress rules for security group. Should be used when new security group is been deployed."
}

variable "existing_sg_egress_rules_with_prefix_list" {
  type        = any
  default     = {}
  description = "Ingress rules for security group. Should be used when new security group is been deployed."
}

variable "new_sg" {
  type    = bool
  default = true
}

variable "sg_description" {
  type    = string
  default = null
}

variable "enable" {
  type    = bool
  default = true
}

variable "prefix_list_address_family" {
  type    = string
  default = "IPv4"
}