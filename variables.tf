variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `prod-sg`)."
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "label_order" {
  type        = list(any)
  default     = []
  description = "Label order, e.g. `name`,`environment`."
}

variable "vpc_id" {
  type        = string
  default     = ""
  description = "The ID of the VPC that the instance security group belongs to."
  sensitive   = true
}

variable "prefix_list_id" {
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
