provider "aws" {
  region = "eu-west-1"
}

locals {
  name           = "app"
  environment    = "test"
  prefix_list_id = "pl-XXXXXXXXXX"
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
  source      = "../.."
  name        = local.name
  environment = local.environment
  vpc_id      = module.vpc.vpc_id

  ## INGRESS Rules
  sg_ingress_rules = [{
    from_port      = 22
    ip_protocol    = "tcp"
    to_port        = 22
    prefix_list_id = local.prefix_list_id
    description    = "Allow ssh traffic."
    }
  ]
  ## EGRESS Rules
  sg_egress_rules = [{
    from_port      = 3306
    ip_protocol    = "tcp"
    to_port        = 3306
    prefix_list_id = local.prefix_list_id
    description    = "Allow mysql/aurora outbound traffic."
    }
  ]
}
