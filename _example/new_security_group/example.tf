####----------------------------------------------------------------------------------
## Provider block added, Use the Amazon Web Services (AWS) provider to interact with the many resources supported by AWS.
####----------------------------------------------------------------------------------
provider "aws" {
  region = "eu-west-1"
}

module "security_group" {
  source = "./../../"

  ## new_enable_security_group #######

  new_enable_security_group = true
  allowed_ip                = ["172.16.0.0/16", "10.0.0.0/16"]
  allowed_ports             = [22, 27017]
  security_groups           = []
  #-------------------------------------------------------------------------------
  ### prefix_list
  #-------------------------------------------------------------------------------
  max_entries         = 5
  prefix_list_enabled = true
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