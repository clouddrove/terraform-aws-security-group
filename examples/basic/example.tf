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
  source      = "../.."
  name        = local.name
  environment = local.environment
  vpc_id      = module.vpc.vpc_id

  ## INGRESS Rules
  sg_ingress_rules = [{
    ip_protocol = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_ipv4   = module.vpc.vpc_cidr_block
    description = "Allow ssh traffic."
    },
    {
      ip_protocol = "tcp"
      from_port   = 22
      to_port     = 22
      cidr_ipv4   = "172.16.0.0/16"
      description = "Allow ssh traffic."
    },
    {
      ip_protocol = "tcp"
      from_port   = 27017
      to_port     = 27017
      cidr_ipv4   = "172.16.0.0/16"
      description = "Allow Mongodb traffic."
    }
  ]

  ## EGRESS Rules
  sg_egress_rules = [{
    ip_protocol = "tcp"
    from_port   = 22
    to_port     = 22
    cidr_ipv4   = module.vpc.vpc_cidr_block
    description = "Allow ssh outbound traffic."
    },
    {
      ip_protocol = "tcp"
      from_port   = 22
      to_port     = 22
      cidr_ipv4   = "172.16.0.0/16"
      description = "Allow ssh outbound traffic."
    },
    {
      ip_protocol = "tcp"
      from_port   = 27017
      to_port     = 27017
      cidr_ipv4   = "172.16.0.0/16"
      description = "Allow Mongodb outbound traffic."
  }]
}
