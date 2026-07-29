terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

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
## Security Group Module Call.
##-----------------------------------------------------------------------------

module "security_group" {
  source              = "../.."
  name                = local.name
  environment         = local.environment
  vpc_id              = module.vpc.vpc_id
  prefix_list_enabled = true
  entry = [{
    cidr = "10.19.0.0/16"
  }]

  ## INGRESS Rules
  sg_ingress_rules = [{
    from_port               = 22
    ip_protocol             = "tcp"
    to_port                 = 22
    use_managed_prefix_list = true
    description             = "Allow ssh traffic."
    }
  ]
  ## EGRESS Rules
  sg_egress_rules = [{
    from_port               = 3306
    ip_protocol             = "tcp"
    to_port                 = 3306
    use_managed_prefix_list = true
    description             = "Allow mysql/aurora outbound traffic."
    }
  ]
}
