provider "aws" {
  region = "eu-west-1"
}

module "vpc" {
  source = "git::https://github.com/clouddrove/terraform-aws-vpc.git?ref=tags/0.12.1"

  name        = "vpc"
  application = "clouddrove"
  environment = "test"
  label_order = ["environment", "name", "application"]

  cidr_block = "10.0.0.0/16"
}

module "security_group" {
  source = "git::https://github.com/clouddrove/terraform-aws-security-group.git?ref=tags/0.12.1"

  name        = "security-group"
  application = "clouddrove"
  environment = "test"
  label_order = ["environment", "name", "application"]

  vpc_id        = module.vpc.vpc_id
  description   = "Instance default security group (only egress access is allowed)."
  allowed_ip    = ["172.16.0.0/16", "10.0.0.0/16"]
  allowed_ports = [22, 27017]
}