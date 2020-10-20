provider "aws" {
  region = "us-east-2"
}

module "vpc" {
  source      = "clouddrove/vpc/aws"
  version     = "0.13.0"
  name        = "vpc"
  application = "clouddrove"
  environment = "test"
  label_order = ["environment", "application", "name"]
  cidr_block = "10.0.0.0/16"
}

module "security_group" {
  source = "./../"

  name        = "security-group"
  application = "clouddrove"
  environment = "test"
  label_order = ["environment", "application", "name"]
  vpc_id        = module.vpc.vpc_id
  protocol      = "tcp"
  description   = "Instance default security group (only egress access is allowed)."
  allowed_ip    = ["172.16.0.0/16", "10.0.0.0/16"]
  allowed_ports = [22, 27017]
}