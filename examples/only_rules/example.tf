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
  source  = "clouddrove/security-group/aws"
  version = "2.0.2"

  name        = local.name
  environment = local.environment

  vpc_id         = "vpc-xxxxxxxxx"
  new_sg         = false
  existing_sg_id = "sg-xxxxxxxxx"

  ## INGRESS Rules
  existing_sg_ingress_rules_with_cidr_blocks = [
    {
      rule_count  = 1
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow all traffic from anywhere."
    },
    {
      rule_count  = 2
      from_port   = -1
      to_port     = -1
      protocol    = "icmp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow ICMP traffic from anywhere."
    },
    {
      rule_count  = 3
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["172.16.0.0/16"]
      description = "Allow TCP 22 traffic from 172.16.0.0/16."
    },
    {
      rule_count  = 4
      from_port   = 51820
      to_port     = 51820
      protocol    = "udp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow UDP 51820 traffic from anywhere."
    },
    {
      rule_count  = 5
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = ["172.16.0.0/16"]
      description = "Allow MySQL traffic from 172.16.0.0/16."
    },
  ]

  existing_sg_ingress_rules_with_self = [{
    rule_count  = 1
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    description = "Allow ssh traffic."
    },
    {
      rule_count  = 2
      from_port   = 27017
      protocol    = "tcp"
      to_port     = 27017
      description = "Allow Mongodb traffic."
  }]

  existing_sg_ingress_rules_with_source_sg_id = [
    {
      rule_count               = 1
      from_port                = 6379
      to_port                  = 6379
      protocol                 = "tcp"
      source_security_group_id = "sg-xxxxxx"
      description              = "Allow Redis traffic from sg-xxxxxx."
    },
    {
      rule_count               = 2
      from_port                = 22
      protocol                 = "tcp"
      to_port                  = 22
      source_security_group_id = "sg-xxxxxxxxx"
      description              = "Allow ssh traffic."
    },
    {
      rule_count               = 3
      from_port                = 27017
      protocol                 = "tcp"
      to_port                  = 27017
      source_security_group_id = "sg-xxxxxxxxx"
      description              = "Allow Mongodb traffic."
  }]

  ## EGRESS Rules
  existing_sg_egress_rules_with_cidr_blocks = [{
    rule_count  = 1
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["10.9.0.0/16"]
    description = "Allow ssh outbound traffic."
    },
    {
      rule_count  = 2
      from_port   = 27017
      protocol    = "tcp"
      to_port     = 27017
      cidr_blocks = ["10.9.0.0/16"]
      description = "Allow Mongodb outbound traffic."
  }]

  existing_sg_egress_rules_with_self = [{
    rule_count  = 1
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    description = "Allow ssh outbound traffic."
    },
    {
      rule_count  = 2
      from_port   = 27017
      protocol    = "tcp"
      to_port     = 27017
      description = "Allow Mongodb outbound traffic."
  }]

  existing_sg_egress_rules_with_source_sg_id = [{
    rule_count               = 1
    from_port                = 22
    protocol                 = "tcp"
    to_port                  = 22
    source_security_group_id = "sg-xxxxxxxxx"
    description              = "Allow ssh outbound traffic."
    },
    {
      rule_count               = 2
      from_port                = 27017
      protocol                 = "tcp"
      to_port                  = 27017
      source_security_group_id = "sg-xxxxxxxxx"
      description              = "Allow Mongodb outbound traffic."
  }]
}