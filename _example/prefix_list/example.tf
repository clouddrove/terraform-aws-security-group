provider "aws" {
  region = "eu-west-1"
}

locals {
  name        = "app"
  environment = "test"
}

##----------------------------------------------------------------------------- 
## VPC Module Call. 
##-----------------------------------------------------------------------------
module "vpc" {
  source      = "clouddrove/vpc/aws"
  version     = "2.0.0"
  name        = local.name
  environment = local.environment
  cidr_block  = "10.0.0.0/16"
}

##----------------------------------------------------------------------------- 
## Security Group Module Call. 
##-----------------------------------------------------------------------------
module "security_group" {
  source              = "clouddrove/security-group/aws"
  version             = "2.0.0"
  name                = local.name
  environment         = local.environment
  vpc_id              = module.vpc.vpc_id
  prefix_list_enabled = true
  entry = [{
    cidr = "10.19.0.0/16"
  }]

  ## INGRESS Rules
  new_sg_ingress_rules_with_prefix_list = [{
    rule_count  = 1
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    description = "Allow ssh traffic."
    }
  ]
  ## EGRESS Rules
  new_sg_egress_rules_with_prefix_list = [{
    rule_count  = 1
    from_port   = 3306
    protocol    = "tcp"
    to_port     = 3306
    description = "Allow mysql/aurora outbound traffic."
    }
  ]
}