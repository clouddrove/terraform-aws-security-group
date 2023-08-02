provider "aws" {
  region = "eu-west-1"
}

locals {
  name        = "app"
  environment = "test"
  label_order = ["name", "environment"]
}

##----------------------------------------------------------------------------- 
## VPC Module Call. 
##-----------------------------------------------------------------------------
module "vpc" {
  source      = "clouddrove/vpc/aws"
  version     = "2.0.0"
  name        = local.name
  environment = local.environment
  label_order = local.label_order
  cidr_block  = "10.0.0.0/16"
}

##----------------------------------------------------------------------------- 
## Security Group Module Call. 
##-----------------------------------------------------------------------------
module "security_group" {
  source              = "./../../"
  name                = local.name
  environment         = local.environment
  vpc_id              = module.vpc.vpc_id
  prefix_list_enabled = true
  entry = [{
    cidr = "10.19.0.0/16"
  }]

  ## INGRESS Rules
  new_sg_ingress_rules_with_prefix_list = [{
    rule_count = 1
    from_port  = 22
    protocol   = "tcp"
    to_port    = 22
    },
    {
      rule_count = 2
      from_port  = 20
      protocol   = "tcp"
      to_port    = 21
    }
  ]
  ## EGRESS Rules
  new_sg_egress_rules_with_prefix_list = [{
    rule_count = 1
    from_port  = 22
    protocol   = "tcp"
    to_port    = 22
    },
    {
      rule_count = 2
      from_port  = 20
      protocol   = "tcp"
      to_port    = 21
    }
  ]
}