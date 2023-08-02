provider "aws" {
  region = "eu-west-1"
}

locals {
  name        = "app"
  environment = "test"
}

##----------------------------------------------------------------------------- 
## Security Group Rules Module Call. 
##-----------------------------------------------------------------------------
module "security_group_rules" {
  source         = "./../../"
  name           = local.name
  environment    = local.environment
  vpc_id         = "vpc-xxxxxxxxx"
  new_sg         = false
  existing_sg_id = "sg-xxxxxxxxx"

  ## INGRESS Rules
  existing_sg_ingress_rules_with_cidr_blocks = [{
    rule_count  = 1
    from_port   = 20
    protocol    = "udp"
    to_port     = 22
    cidr_blocks = ["10.9.0.0/16"]
    },
    {
      rule_count  = 2
      from_port   = 27017
      protocol    = "tcp"
      to_port     = 27017
      cidr_blocks = ["10.9.0.0/16"]
    }
  ]

  existing_sg_ingress_rules_with_self = [{
    rule_count = 1
    from_port  = 20
    protocol   = "tcp"
    to_port    = 22
    },
    {
      rule_count = 2
      from_port  = 270
      protocol   = "tcp"
      to_port    = 270
    }
  ]

  existing_sg_ingress_rules_with_source_sg_id = [{
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
  existing_sg_egress_rules_with_cidr_blocks = [{
    rule_count  = 1
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["10.9.0.0/16"]
    },
    {
      rule_count  = 2
      from_port   = 27017
      protocol    = "tcp"
      to_port     = 27017
      cidr_blocks = ["10.9.0.0/16"]
  }]

  existing_sg_egress_rules_with_self = [{
    rule_count = 1
    from_port  = 20
    protocol   = "tcp"
    to_port    = 22
    },
    {
      rule_count = 2
      from_port  = 270
      protocol   = "tcp"
      to_port    = 270
  }]

  existing_sg_egress_rules_with_source_sg_id = [{
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