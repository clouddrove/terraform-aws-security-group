# Managed By : CloudDrove
# Description : This Script is used to create security group.
# Copyright @ CloudDrove. All Right Reserved.

#Module      : Label
#Description : This terraform module is designed to generate consistent label names and tags
#              for resources. You can use terraform-labels to implement a strict naming
#              convention.

module "labels" {
  source = "git::https://github.com/clouddrove/terraform-labels.git?ref=tags/0.12.0"

  name        = var.name
  application = var.application
  environment = var.environment
  managedby   = var.managedby
  label_order = var.label_order
}

locals {
  security_group_count           = var.enable_security_group == true ? 1 : 0
  enable_cidr_rules              = var.enable_security_group && (length(var.allowed_ip) > 0)
  enable_source_sec_group_rules  = var.enable_security_group && (length(var.security_groups) > 0)
  ports_source_sec_group_product = setproduct(compact(var.allowed_ports), compact(var.security_groups))
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

#Module      : SECURITY GROUP RULE FOR EGRESS
#Description : Provides a security group rule resource. Represents a single egress
#              group rule, which can be added to external Security Groups.
resource "aws_security_group_rule" "egress" {
  count = var.enable_security_group == true ? 1 : 0

  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = join("", aws_security_group.default.*.id)
}

resource "aws_security_group_rule" "egress_ipv6" {
  count = var.enable_security_group == true ? 1 : 0

  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = join("", aws_security_group.default.*.id)
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
  security_group_id = join("", aws_security_group.default.*.id)
}

resource "aws_security_group_rule" "ingress_ipv6" {
  count = local.enable_cidr_rules == true ? length(compact(var.allowed_ports)) : 0

  type              = "ingress"
  from_port         = element(var.allowed_ports, count.index)
  to_port           = element(var.allowed_ports, count.index)
  protocol          = var.protocol
  ipv6_cidr_blocks  = var.allowed_ipv6
  security_group_id = join("", aws_security_group.default.*.id)
}

resource "aws_security_group_rule" "ingress_sg" {
  count = local.enable_source_sec_group_rules == true ? length(local.ports_source_sec_group_product) : 0

  type                     = "ingress"
  from_port                = element(element(local.ports_source_sec_group_product, count.index), 0)
  to_port                  = element(element(local.ports_source_sec_group_product, count.index), 0)
  protocol                 = var.protocol
  source_security_group_id = element(element(local.ports_source_sec_group_product, count.index), 1)
  security_group_id        = join("", aws_security_group.default.*.id)
}
