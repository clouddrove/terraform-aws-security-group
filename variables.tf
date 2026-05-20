variable "name" {
  type        = string
  default     = ""
  description = "Name (e.g. app or cluster)."
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. prod, dev, staging)."
}

variable "label_order" {
  type        = list(any)
  default     = ["name", "environment"]
  description = "Label order."
}

variable "repository" {
  type        = string
  default     = "https://github.com/clouddrove/terraform-aws-security-group"
  description = "Terraform current module repo."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags."
}

variable "managedby" {
  type        = string
  default     = "hello@clouddrove.com"
  description = "ManagedBy, eg 'CloudDrove'."
}

variable "vpc_id" {
  type        = string
  default     = ""
  description = "VPC ID the security group belongs to."
  sensitive   = true
}

variable "enable" {
  type        = bool
  default     = true
  description = "Flag to control module creation."
}

variable "new_sg" {
  type        = bool
  default     = true
  description = "Create a new security group. Set false to manage rules on an existing SG via existing_sg_id."
}

variable "sg_description" {
  type        = string
  default     = "Managed by Terraform"
  description = "Security group description. Cannot be updated in-place — forces replacement."
}

variable "revoke_rules_on_delete" {
  type        = bool
  default     = false
  description = "Revoke all rules before deleting the SG. Required for EMR and similar services that inject their own rules."
}

variable "existing_sg_id" {
  type        = string
  default     = null
  description = "ID of a pre-existing security group to add rules to."
}

##-----------------------------------------------------------------------------
## Rule object type used for all ingress/egress rule variables.
## Exactly one of cidr_ipv4, cidr_ipv6, prefix_list_id, or
## referenced_security_group_id must be set per rule.
## key must be unique and stable — it is used as the for_each map key.
##-----------------------------------------------------------------------------
variable "new_sg_ingress_rules" {
  description = "Ingress rules for the newly created security group."
  type = list(object({
    key                          = string
    ip_protocol                  = string
    from_port                    = optional(number)
    to_port                      = optional(number)
    cidr_ipv4                    = optional(string)
    cidr_ipv6                    = optional(string)
    prefix_list_id               = optional(string)
    referenced_security_group_id = optional(string)
    description                  = optional(string, "Managed by Terraform")
    tags                         = optional(map(string), {})
  }))
  default = []
}

variable "new_sg_egress_rules" {
  description = "Egress rules for the newly created security group. Default allows all IPv4 egress."
  type = list(object({
    key                          = string
    ip_protocol                  = string
    from_port                    = optional(number)
    to_port                      = optional(number)
    cidr_ipv4                    = optional(string)
    cidr_ipv6                    = optional(string)
    prefix_list_id               = optional(string)
    referenced_security_group_id = optional(string)
    description                  = optional(string, "Managed by Terraform")
    tags                         = optional(map(string), {})
  }))
  default = [
    {
      key         = "allow-all-ipv4-egress"
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
      description = "Allow all IPv4 egress"
    }
  ]
}

variable "existing_sg_ingress_rules" {
  description = "Ingress rules to add to an existing security group (requires existing_sg_id)."
  type = list(object({
    key                          = string
    ip_protocol                  = string
    from_port                    = optional(number)
    to_port                      = optional(number)
    cidr_ipv4                    = optional(string)
    cidr_ipv6                    = optional(string)
    prefix_list_id               = optional(string)
    referenced_security_group_id = optional(string)
    description                  = optional(string, "Managed by Terraform")
    tags                         = optional(map(string), {})
  }))
  default = []
}

variable "existing_sg_egress_rules" {
  description = "Egress rules to add to an existing security group (requires existing_sg_id)."
  type = list(object({
    key                          = string
    ip_protocol                  = string
    from_port                    = optional(number)
    to_port                      = optional(number)
    cidr_ipv4                    = optional(string)
    cidr_ipv6                    = optional(string)
    prefix_list_id               = optional(string)
    referenced_security_group_id = optional(string)
    description                  = optional(string, "Managed by Terraform")
    tags                         = optional(map(string), {})
  }))
  default = []
}

##-----------------------------------------------------------------------------
## Prefix list
##-----------------------------------------------------------------------------
variable "prefix_list_enabled" {
  type        = bool
  default     = false
  description = "Create a managed prefix list."
}

variable "prefix_list_ids" {
  type        = list(string)
  default     = []
  description = "Existing prefix list IDs to reference in rules. If empty and prefix_list_enabled=true, a new one is created."
}

variable "prefix_list_address_family" {
  type        = string
  default     = "IPv4"
  description = "Address family for the managed prefix list: IPv4 or IPv6."
}

variable "max_entries" {
  type        = number
  default     = 5
  description = "Maximum entries in the managed prefix list."
}

variable "entry" {
  type        = list(any)
  default     = []
  description = "Entries for the managed prefix list."
}
