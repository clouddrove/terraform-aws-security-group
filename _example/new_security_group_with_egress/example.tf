####----------------------------------------------------------------------------------
## Provider block added, Use the Amazon Web Services (AWS) provider to interact with the many resources supported by AWS.
####----------------------------------------------------------------------------------
provider "aws" {
  region = "eu-west-1"
}
####----------------------------------------------------------------------------------
## A VPC is a virtual network that closely resembles a traditional network that you'd operate in your own data center.
####----------------------------------------------------------------------------------
module "vpc" {
  source  = "clouddrove/vpc/aws"
  version = "1.3.1"

  name        = "vpc"
  environment = "test"
  label_order = ["name", "environment"]
  cidr_block  = "10.0.0.0/16"
}
##----------------------------------------------------------------------------------
## Below module will create SECURITY-GROUP and its components.
##----------------------------------------------------------------------------------
module "security_group" {
  source = "./../../"

  name        = "security-group"
  environment = "test"
  label_order = ["name", "environment"]

  vpc_id                 = module.vpc.vpc_id
  prefix_list_enabled    = false
  allowed_ip             = ["172.16.0.0/16", "10.0.0.0/16"]
  allowed_ipv6           = ["2405:201:5e00:3684:cd17:9397:5734:a167/128"]
  allowed_ports          = [22, 27017]
  security_groups        = ["sg-xxxxxxxxx"]
  prefix_list_id         = ["pl-6da54004"]
  egress_rule            = true
  egress_allowed_ip      = ["172.16.0.0/16", "10.0.0.0/16"]
  egress_allowed_ports   = [22, 27017]
  egress_protocol        = "tcp"
  egress_prefix_list_ids = ["pl-xxxxxxxxx"]
  egress_security_groups = ["sg-xxxxxxxxx"]
}
