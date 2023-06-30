
####----------------------------------------------------------------------------------
## A VPC is a virtual network that closely resembles a traditional network that you'd operate in your own data center.
####----------------------------------------------------------------------------------

module "vpc" {
  source      = "clouddrove/vpc/aws"
  version     = "1.3.1"
  name        = "vpc"
  environment = "prashant"
  label_order = ["name", "environment"]
  cidr_block  = "10.0.0.0/16"
}

module "prefix_list" {
  source = "./modules/prefix_list"

  name        = "prefix_list"
  environment = "prashant"
  label_order = ["name", "environment"]

  max_entries         = var.max_entries
  prefix_list_enabled = var.prefix_list_enabled
  entry = var.entry
}

##----------------------------------------------------------------------------------
## Below module will create SECURITY-GROUP and its components.
##----------------------------------------------------------------------------------
module "security_group" {
  source = "./modules/security_group"

  name        = "security-group"
  environment = "test"
  label_order = ["name", "environment"]

  enable_security_group = var.new_enable_security_group
  vpc_id          = module.vpc.vpc_id
  allowed_ip      = var.allowed_ip
  allowed_ports   = var.allowed_ports
  security_groups = var.security_groups
  prefix_list_ids = length(var.prefix_list_id) < 1 ? module.prefix_list.prefix_id : var.prefix_list_id
}