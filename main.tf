# Managed By : CloudDrove
# Description : This Script is used to create Security Group.
# Copyright @ CloudDrove. All Right Reserved.

#Module      : Label
#Description : This terraform module is designed to generate consistent label names and tags
#              for resources. You can use terraform-labels to implement a strict naming
#              convention.

module "labels" {
  source  = "clouddrove/labels/aws"
  version = "0.15.0"

  enabled     = var.enable_security_group
  name        = var.name
  repository  = var.repository
  environment = var.environment
  attributes  = var.attributes
  managedby   = var.managedby
  label_order = var.label_order
}

locals {
  sg_existing                    = var.is_external == true
  egress_rule                    = var.egress_rule == true
  id                             = local.sg_existing ? join("", data.aws_security_group.existing.*.id) : join("", aws_security_group.default.*.id)
  security_group_count           = var.enable_security_group == true ? 1 : 0
  enable_cidr_rules              = length(var.allowed_ip) > 0
  enable_cidr_rules_ipv6         = length(var.allowed_ipv6) > 0
  enable_source_sec_group_rules  = length(var.security_groups) == 0 ? false : true
  enable_source_prefix_list_ids  = length(var.prefix_list_ids) == 0 ? false : true
  ports_source_sec_group_product = setproduct(compact(var.allowed_ports), length(var.security_groups) > 0 ? var.security_groups : [""])
  ports_source_prefix_product    = setproduct(compact(var.allowed_ports), length(var.prefix_list_ids) > 0 ? var.prefix_list_ids : [""])
  prefix_list                    = var.prefix_list_ids

  #egress local parameters
  enable_source_sec_group_rules_eg = length(var.egress_security_groups) == 0 ? false : true
  enable_source_prefix_list_ids_eg = length(var.egress_prefix_list_ids) == 0 ? false : true
  enable_cidr_rules_ipv6_eg        = length(var.egress_allowed_ipv6) > 0

  ports_source_sec_group_product_eg = setproduct(
    length(var.egress_allowed_ports) > 0 ? compact(var.egress_allowed_ports) : [""],
  length(var.egress_security_groups) > 0 ? var.egress_security_groups : [""])
  ports_source_prefix_product_eg = setproduct(
    length(var.egress_allowed_ports) > 0 ? compact(var.egress_allowed_ports) : [""],
  length(var.egress_prefix_list_ids) > 0 ? var.egress_prefix_list_ids : [""])
  prefix_list_eg = var.egress_prefix_list_ids

}

#Module      : SECURITY GROUP
#Description : Here are an example of how you can use this module in your inventory
#              structure:
resource "aws_security_group" "default" {
  count = local.security_group_count

  name        = module.labels.id
  vpc_id      = var.vpc_id
  description = var.description
  tags        = module.labels.tags
  lifecycle {
    create_before_destroy = true
  }
}

data "aws_security_group" "existing" {
  count  = local.sg_existing ? 1 : 0
  id     = var.existing_sg_id
  vpc_id = var.vpc_id
}

#Module      : SECURITY GROUP RULE FOR EGRESS
#Description : Provides a security group rule resource. Represents a single egress
#              group rule, which can be added to external Security Groups.
resource "aws_security_group_rule" "egress" {
  count = (var.enable_security_group == true && local.sg_existing == false && local.egress_rule == false) ? 1 : 0

  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"] #tfsec:ignore:aws-vpc-no-public-egress-sgr
  security_group_id = local.id
}
resource "aws_security_group_rule" "egress_ipv6" {
  count = (var.enable_security_group == true && local.sg_existing == false) && local.egress_rule == false && local.enable_cidr_rules_ipv6 == true ? 1 : 0

  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  ipv6_cidr_blocks  = ["::/0"] #tfsec:ignore:aws-vpc-no-public-egress-sgr
  security_group_id = local.id
  prefix_list_ids   = var.prefix_list
}
#Module      : SECURITY GROUP RULE FOR INGRESS
#Description : Provides a security group rule resource. Represents a single ingress
#              group rule, which can be added to external Security Groups.
resource "aws_security_group_rule" "ingress" {
  count = local.enable_cidr_rules == true ? length(compact(var.allowed_ports)) : 0

  type              = "ingress"
  from_port         = element(var.allowed_ports, count.index)
  to_port           = element(var.allowed_ports, count.index)
  protocol          = var.protocol
  cidr_blocks       = var.allowed_ip
  security_group_id = local.id
}
resource "aws_security_group_rule" "ingress_ipv6" {
  count = local.enable_cidr_rules_ipv6 == true ? length(compact(var.allowed_ports)) : 0

  type              = "ingress"
  from_port         = element(var.allowed_ports, count.index)
  to_port           = element(var.allowed_ports, count.index)
  protocol          = var.protocol
  ipv6_cidr_blocks  = var.allowed_ipv6
  security_group_id = local.id
}

resource "aws_security_group_rule" "ingress_sg" {
  count = local.enable_source_sec_group_rules == true ? length(local.ports_source_sec_group_product) : 0

  type                     = "ingress"
  from_port                = element(element(local.ports_source_sec_group_product, count.index), 0)
  to_port                  = element(element(local.ports_source_sec_group_product, count.index), 0)
  protocol                 = var.protocol
  source_security_group_id = local.enable_source_sec_group_rules == true ? element(element(local.ports_source_sec_group_product, count.index), 1) : 0
  security_group_id        = local.id
}

resource "aws_security_group_rule" "ingress_prefix" {
  count = local.enable_source_prefix_list_ids == true ? length(local.ports_source_prefix_product) : 0

  type              = "ingress"
  from_port         = element(element(local.ports_source_prefix_product, count.index), 0)
  to_port           = element(element(local.ports_source_prefix_product, count.index), 0)
  protocol          = var.protocol
  prefix_list_ids   = [element(element(local.ports_source_prefix_product, count.index), 1)]
  security_group_id = local.id
}

#egress rules configuration

resource "aws_security_group_rule" "egress_ipv4_rule" {
  count = local.egress_rule == true ? length(compact(var.allowed_ports)) : 0

  type              = "egress"
  from_port         = element(var.egress_allowed_ports, count.index)
  to_port           = element(var.egress_allowed_ports, count.index)
  protocol          = var.egress_protocol
  cidr_blocks       = var.egress_allowed_ip
  security_group_id = local.id
}

resource "aws_security_group_rule" "egress_ipv6_rule" {
  count = local.egress_rule == true && local.enable_cidr_rules_ipv6_eg == true ? 1 : 0

  type              = "egress"
  from_port         = element(var.egress_allowed_ports, count.index)
  to_port           = element(var.egress_allowed_ports, count.index)
  protocol          = var.egress_protocol
  ipv6_cidr_blocks  = var.egress_allowed_ipv6
  security_group_id = local.id
  prefix_list_ids   = var.prefix_list
}

resource "aws_security_group_rule" "egress_sg_rule" {
  count = local.egress_rule == true && local.enable_source_sec_group_rules_eg == true ? length(local.ports_source_sec_group_product_eg) : 0

  type                     = "egress"
  from_port                = element(element(local.ports_source_sec_group_product_eg, count.index), 0)
  to_port                  = element(element(local.ports_source_sec_group_product_eg, count.index), 0)
  protocol                 = var.egress_protocol
  source_security_group_id = element(element(local.ports_source_sec_group_product_eg, count.index), 1)
  security_group_id        = local.id
}

resource "aws_security_group_rule" "egress_prefix_rule" {
  count = local.egress_rule == true && local.enable_source_prefix_list_ids_eg == true ? length(local.ports_source_prefix_product) : 0

  type              = "egress"
  from_port         = element(element(local.ports_source_prefix_product_eg, count.index), 0)
  to_port           = element(element(local.ports_source_prefix_product_eg, count.index), 0)
  protocol          = var.egress_protocol
  prefix_list_ids   = [element(element(local.ports_source_prefix_product_eg, count.index), 1)]
  security_group_id = local.id
}
