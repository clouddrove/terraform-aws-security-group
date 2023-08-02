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
  source      = "./../../"
  name        = local.name
  environment = local.environment
  vpc_id      = module.vpc.vpc_id

  ## INGRESS Rules
  new_sg_ingress_rules_with_cidr_blocks = [{
    rule_count  = 1
    from_port   = 20
    protocol    = "udp"
    to_port     = 22
    cidr_blocks = [module.vpc.vpc_cidr_block, "172.16.0.0/16"]
    },
    {
      rule_count  = 2
      from_port   = 27017
      protocol    = "tcp"
      to_port     = 27017
      cidr_blocks = ["172.16.0.0/16"]
    }
  ]

  new_sg_ingress_rules_with_self = [{
    rule_count = 1
    from_port  = 22
    protocol   = "tcp"
    to_port    = 22
    },
    {
      rule_count = 2
      from_port  = 27017
      protocol   = "-1"
      to_port    = 27017
    }
  ]

  new_sg_ingress_rules_with_source_sg_id = [{
    rule_count               = 1
    from_port                = 22
    protocol                 = "tcp"
    to_port                  = 22
    source_security_group_id = "sg-xxxxxxxxx"
    },
    {
      rule_count               = 2
      from_port                = 27017
      protocol                 = "tcp"
      to_port                  = 27017
      source_security_group_id = "sg-xxxxxxxxx"
    },
    {
      rule_count               = 3
      from_port                = 22
      protocol                 = "tcp"
      to_port                  = 22
      source_security_group_id = "sg-xxxxxxxxx"
  }]

  ## EGRESS Rules
  new_sg_egress_rules_with_cidr_blocks = [{
    rule_count  = 1
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = [module.vpc.vpc_cidr_block, "172.16.0.0/16"]
    },
    {
      rule_count  = 2
      from_port   = 27017
      protocol    = "tcp"
      to_port     = 27017
      cidr_blocks = ["172.16.0.0/16"]
  }]

  new_sg_egress_rules_with_self = [{
    rule_count = 1
    from_port  = 22
    protocol   = "tcp"
    to_port    = 22
    },
    {
      rule_count = 2
      from_port  = 27017
      protocol   = "tcp"
      to_port    = 27017
  }]

  new_sg_egress_rules_with_source_sg_id = [{
    rule_count               = 1
    from_port                = 22
    protocol                 = "tcp"
    to_port                  = 22
    source_security_group_id = "sg-xxxxxxxxx"
    },
    {
      rule_count               = 2
      from_port                = 27017
      protocol                 = "tcp"
      to_port                  = 27017
      source_security_group_id = "sg-xxxxxxxxx"
    },
    {
      rule_count               = 3
      from_port                = 22
      protocol                 = "tcp"
      to_port                  = 22
      source_security_group_id = "sg-xxxxxxxxx"
  }]
}