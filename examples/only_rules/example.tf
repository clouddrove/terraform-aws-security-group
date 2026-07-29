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
## Security Group Rules Module Call.
##-----------------------------------------------------------------------------
module "security_group_rules" {
  source = "../.."

  name           = local.name
  environment    = local.environment
  vpc_id         = "vpc-XXXXXXXXXXXXXXXX"
  sg             = false
  existing_sg_id = "sg-XXXXXXXXXXXXXXXX"

  ## INGRESS Rules
  existing_sg_ingress_rules = [
    {
      from_port   = 0
      to_port     = 0
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
      description = "Allow all traffic from anywhere."
    },
    {
      from_port   = -1
      to_port     = -1
      ip_protocol = "icmp"
      cidr_ipv4   = "0.0.0.0/0"
      description = "Allow ICMP traffic from anywhere."
    },
    {
      from_port   = 22
      to_port     = 22
      ip_protocol = "tcp"
      cidr_ipv4   = "172.16.0.0/16"
      description = "Allow TCP 22 traffic from 172.16.0.0/16."
    },
    {
      from_port   = 51820
      to_port     = 51820
      ip_protocol = "udp"
      cidr_ipv4   = "0.0.0.0/0"
      description = "Allow UDP 51820 traffic from anywhere."
    },
    {
      from_port   = 3306
      to_port     = 3306
      ip_protocol = "tcp"
      cidr_ipv4   = "172.16.0.0/16"
      description = "Allow MySQL traffic from 172.16.0.0/16."
    },
    {
      from_port                    = 6379
      to_port                      = 6379
      ip_protocol                  = "tcp"
      referenced_security_group_id = "sg-xxxxxx"
      description                  = "Allow Redis traffic from sg-xxxxxx."
    },
    {
      from_port                    = 22
      ip_protocol                  = "tcp"
      to_port                      = 22
      referenced_security_group_id = "sg-xxxxxxxxx"
      description                  = "Allow ssh traffic."
    },
    {
      from_port                    = 27017
      ip_protocol                  = "tcp"
      to_port                      = 27017
      referenced_security_group_id = "sg-xxxxxxxxx"
      description                  = "Allow Mongodb traffic."
  }]

  ## EGRESS Rules
  existing_sg_egress_rules = [{
    from_port   = 22
    ip_protocol = "tcp"
    to_port     = 22
    cidr_ipv4   = "10.9.0.0/16"
    description = "Allow ssh outbound traffic."
    },
    {
      from_port   = 27017
      ip_protocol = "tcp"
      to_port     = 27017
      cidr_ipv4   = "10.9.0.0/16"
      description = "Allow Mongodb outbound traffic."
    },
    {
      from_port                    = 22
      ip_protocol                  = "tcp"
      to_port                      = 22
      referenced_security_group_id = "sg-xxxxxxxxx"
      description                  = "Allow ssh outbound traffic."
    },
    {
      from_port                    = 27017
      ip_protocol                  = "tcp"
      to_port                      = 27017
      referenced_security_group_id = "sg-xxxxxxxxx"
      description                  = "Allow Mongodb outbound traffic."
  }]
}