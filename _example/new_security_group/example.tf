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


module "security_group" {
  source = "./../../"

  name        = "security-group"
  environment = "test"
  label_order = ["name", "environment"]

  ## new_enable_security_group #######
  vpc_id                    = module.vpc.vpc_id
  new_enable_security_group = true
  allowed_ip                = ["172.16.0.0/16", "10.0.0.0/16"]
  allowed_ports             = [22, 27017]
  security_groups           = []

  ### prefix_list
  max_entries         = 5
  prefix_list_enabled = true
  prefix_list_id      = []
  entry = [
    {
      cidr        = "10.0.0.0/16"
      description = "VPC CIDR"
    },
    {
      cidr        = "10.10.0.0/24"
      description = "VPC CIDR"
    }
  ]
}
