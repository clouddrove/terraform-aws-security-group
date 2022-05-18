provider "aws" {
  region = "eu-west-1"
}

module "vpc" {
  source      = "clouddrove/vpc/aws"
  version     = "0.15.1"
  name        = "vpc"
  environment = "test"
  label_order = ["name", "environment"]
  cidr_block  = "10.0.0.0/16"
}

module "security_group" {
  source = "../../"

  name        = "security-group"
  environment = "test"
  label_order = ["name", "environment"]

  enable_security_group = true
  vpc_id                = module.vpc.vpc_id
  protocol              = "tcp"
  description           = "Instance default security group (only egress access is allowed)."
  allowed_ip            = ["172.16.0.0/16", "10.0.0.0/16"]
  allowed_ipv6          = ["2405:201:5e00:3684:cd17:9397:5734:a167/128"]
  allowed_ports         = [22, 27017]
  security_groups       = ["sg-xxxxxxxx"]
  prefix_list_ids       = ["pl-xxxxxxxx"]
}
