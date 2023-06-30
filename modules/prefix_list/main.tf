##----------------------------------------------------------------------------------
## This terraform module is designed to generate consistent label names and
## tags for resources. You can use terraform-labels to implement a strict naming convention.
##----------------------------------------------------------------------------------
module "labels" {
  source  = "clouddrove/labels/aws"
  version = "1.3.0"

  name        = var.name
  repository  = var.repository
  environment = var.environment
  attributes  = var.attributes
  managedby   = var.managedby
  label_order = var.label_order
}

resource "aws_ec2_managed_prefix_list" "prefix_list_sg_example" {
  count = var.prefix_list_enabled && length(var.prefix_list_id) < 1 ? 1 : 0

  address_family = "IPv4"
  max_entries    = var.max_entries
  name           = module.labels.id

  dynamic "entry" {
    for_each = var.entry
    content {
      cidr        = lookup(entry.value, "cidr", null)
      description = lookup(entry.value, "description", null)

    }
  }
}
