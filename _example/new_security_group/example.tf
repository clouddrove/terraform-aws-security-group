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
  source      = "clouddrove/vpc/aws"
  version     = "2.0.0"
  name        = "vpc"
  environment = "test"
  label_order = ["name", "environment"]
  cidr_block  = "10.0.0.0/16"
}


module "security_group" {
  source = "./../../"

  name        = "security-group"
  environment = "test"
  vpc_id      = module.vpc.vpc_id
  # allowed_ip                = ["172.16.0.0/16", "10.0.0.0/16"]
  # allowed_ports             = [22, 27017]
  # security_groups           = []
  new_sg_ingress_rules_with_cidr_blocks = [{
    from_port   = 22
    protocol    = "-1"
    to_port     = 22
    cidr_blocks = [module.vpc.vpc_cidr_block, "172.16.0.0/16"]
    },
    {
      from_port   = 27017
      protocol    = "tcp"
      to_port     = 27017
      cidr_blocks = ["172.16.0.0/16"]
  }]
}