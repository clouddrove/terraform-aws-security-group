provider "aws" {
  region = "eu-west-1"
}

locals {
  name        = "security-group"
  environment = "test"
  label_order = ["name", "environment"]
}

##-----------------------------------------------------------------------------
## VPC Module Call.
##-----------------------------------------------------------------------------
module "vpc" {
  source      = "clouddrove/vpc/aws"
  version     = "2.0.5"
  name        = local.name
  environment = local.environment
  cidr_block  = "10.0.0.0/16"
}

##-----------------------------------------------------------------------------
## Security Group Module Call.
##-----------------------------------------------------------------------------
module "security_group" {
  source      = "../../"
  name        = local.name
  environment = local.environment
  protocol    = "tcp"
  label_order = local.label_order
  vpc_id      = module.vpc.vpc_id

  allowed_ip   = ["171.35.0.0/16", "174.129.196.151/32", "192.168.200.0/22", "10.81.234.0/24"]
  allowed_ipv6 = ["2001:db8:1234::/64"]

  allowed_ports = [27017]
}
