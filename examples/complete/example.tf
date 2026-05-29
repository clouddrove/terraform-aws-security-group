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
  version     = "2.0.5"
  name        = local.name
  environment = local.environment
  cidr_block  = "10.0.0.0/16"
}

##-----------------------------------------------------------------------------
## Source Security Group.
## This SG is referenced by source_security_group_id rules below.
##-----------------------------------------------------------------------------
resource "aws_security_group" "source" {
  name        = "${local.name}-${local.environment}-source"
  description = "Source security group for testing SG reference rules"
  vpc_id      = module.vpc.vpc_id

  tags = {
    Name        = "${local.name}-${local.environment}-source"
    Environment = local.environment
  }
}

##-----------------------------------------------------------------------------
## Security Group Module Call.
##-----------------------------------------------------------------------------
module "security_group" {
  source      = "clouddrove/security-group/aws"
  version     = "2.0.2"
  name        = local.name
  environment = local.environment
  vpc_id      = module.vpc.vpc_id

  ## INGRESS Rules
  new_sg_ingress_rules_with_cidr_blocks = [
    {
      rule_count  = 1
      from_port   = 22
      protocol    = "tcp"
      to_port     = 22
      cidr_blocks = [module.vpc.vpc_cidr_block, "172.16.0.0/16"]
      description = "Allow ssh traffic."
    },
    {
      rule_count  = 2
      from_port   = 27017
      protocol    = "tcp"
      to_port     = 27017
      cidr_blocks = ["172.16.0.0/16"]
      description = "Allow Mongodb traffic."
    }
  ]

  new_sg_ingress_rules_with_self = [
    {
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
    }
  ]

  new_sg_ingress_rules_with_source_sg_id = [
    {
      rule_count               = 1
      from_port                = 22
      protocol                 = "tcp"
      to_port                  = 22
      source_security_group_id = aws_security_group.source.id
      description              = "Allow ssh traffic from source security group."
    },
    {
      rule_count               = 2
      from_port                = 27017
      protocol                 = "tcp"
      to_port                  = 27017
      source_security_group_id = aws_security_group.source.id
      description              = "Allow Mongodb traffic from source security group."
    }
  ]

  ## EGRESS Rules
  new_sg_egress_rules_with_cidr_blocks = [
    {
      rule_count  = 1
      from_port   = 22
      protocol    = "tcp"
      to_port     = 22
      cidr_blocks = [module.vpc.vpc_cidr_block, "172.16.0.0/16"]
      description = "Allow ssh outbound traffic."
    },
    {
      rule_count  = 2
      from_port   = 27017
      protocol    = "tcp"
      to_port     = 27017
      cidr_blocks = ["172.16.0.0/16"]
      description = "Allow Mongodb outbound traffic."
    }
  ]

  new_sg_egress_rules_with_self = [
    {
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
      description = "Allow Mongodb traffic."
    }
  ]

  new_sg_egress_rules_with_source_sg_id = [
    {
      rule_count               = 1
      from_port                = 22
      protocol                 = "tcp"
      to_port                  = 22
      source_security_group_id = aws_security_group.source.id
      description              = "Allow ssh outbound traffic to source security group."
    },
    {
      rule_count               = 2
      from_port                = 27017
      protocol                 = "tcp"
      to_port                  = 27017
      source_security_group_id = aws_security_group.source.id
      description              = "Allow Mongodb outbound traffic to source security group."
    }
  ]
}