#-------------------------------------------------------------------------------
### prefix_list
#-------------------------------------------------------------------------------
module "prefix_list" {
  source = "./modules/prefix_list"

  name        = var.name
  environment = var.environment
  label_order = var.label_order

  max_entries         = var.max_entries
  prefix_list_enabled = var.prefix_list_enabled
  entry               = var.entry
}

##----------------------------------------------------------------------------------
## Below module will create SECURITY-GROUP and its components.
##----------------------------------------------------------------------------------
module "security_group" {
  source = "./modules/security_group"

  name        = "security-group"
  environment = "test"
  label_order = ["name", "environment"]

  enable_security_group  = var.new_enable_security_group
  vpc_id                 = var.vpc_id
  allowed_ip             = var.allowed_ip
  allowed_ports          = var.allowed_ports
  security_groups        = var.security_groups
  allowed_ipv6           = var.allowed_ipv6
  egress_rule            = var.egress_rule
  egress_allowed_ip      = var.egress_allowed_ip
  egress_allowed_ports   = var.egress_allowed_ports
  egress_protocol        = var.egress_protocol
  egress_prefix_list_ids = var.egress_prefix_list_ids
  egress_security_groups = var.egress_security_groups
  is_external = var.is_external
  existing_sg_id = var.existing_sg_id
  prefix_list_ids        = length(var.prefix_list_id) < 1 ? module.prefix_list.prefix_id : var.prefix_list_id
}