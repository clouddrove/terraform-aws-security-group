# Managed By : CloudDrove
# Copyright @ CloudDrove. All Right Reserved.

module "labels" {
  source      = "clouddrove/labels/aws"
  version     = "1.3.1"
  name        = var.name
  environment = var.environment
  managedby   = var.managedby
  label_order = var.label_order
  repository  = var.repository
  extra_tags  = var.tags
}

##-----------------------------------------------------------------------------
## Security group — inline ingress/egress blocks intentionally omitted.
## All rules managed via aws_vpc_security_group_*_rule resources below.
##-----------------------------------------------------------------------------
resource "aws_security_group" "default" {
  count                  = var.enable && var.new_sg ? 1 : 0
  name_prefix            = format("%s-sg-", module.labels.id)
  vpc_id                 = var.vpc_id
  description            = var.sg_description
  revoke_rules_on_delete = var.revoke_rules_on_delete
  tags                   = module.labels.tags
  lifecycle {
    create_before_destroy = true
  }
  timeouts {
    delete = "60m"
  }
}

data "aws_security_group" "existing" {
  count  = var.enable && var.existing_sg_id != null ? 1 : 0
  id     = var.existing_sg_id
  vpc_id = var.vpc_id
}

resource "aws_ec2_managed_prefix_list" "prefix_list" {
  count          = var.enable && var.prefix_list_enabled && length(var.prefix_list_ids) < 1 ? 1 : 0
  address_family = var.prefix_list_address_family
  max_entries    = var.max_entries
  name           = format("%s-prefix-list", module.labels.id)
  dynamic "entry" {
    for_each = var.entry
    content {
      cidr        = lookup(entry.value, "cidr", null)
      description = lookup(entry.value, "description", null)
    }
  }
}

locals {
  new_sg_id      = var.enable && var.new_sg ? aws_security_group.default[0].id : null
  existing_sg_id = var.enable && var.existing_sg_id != null ? data.aws_security_group.existing[0].id : null
}

##-----------------------------------------------------------------------------
## Ingress rules — new SG. Uses aws_vpc_security_group_ingress_rule (provider
## 5.x), replacing the deprecated aws_security_group_rule. One resource per
## source. key field must be unique and stable across rule list changes.
##-----------------------------------------------------------------------------
resource "aws_vpc_security_group_ingress_rule" "new_sg_cidr" {
  for_each = var.enable && var.new_sg ? {
    for rule in var.new_sg_ingress_rules : rule.key => rule
    if rule.cidr_ipv4 != null || rule.cidr_ipv6 != null
  } : {}
  security_group_id = local.new_sg_id
  ip_protocol       = each.value.ip_protocol
  from_port         = each.value.ip_protocol == "-1" ? null : each.value.from_port
  to_port           = each.value.ip_protocol == "-1" ? null : each.value.to_port
  cidr_ipv4         = each.value.cidr_ipv4
  cidr_ipv6         = each.value.cidr_ipv6
  description       = each.value.description
  tags              = merge(module.labels.tags, each.value.tags)
}

resource "aws_vpc_security_group_ingress_rule" "new_sg_source_sg" {
  for_each = var.enable && var.new_sg ? {
    for rule in var.new_sg_ingress_rules : rule.key => rule
    if rule.referenced_security_group_id != null
  } : {}
  security_group_id            = local.new_sg_id
  ip_protocol                  = each.value.ip_protocol
  from_port                    = each.value.ip_protocol == "-1" ? null : each.value.from_port
  to_port                      = each.value.ip_protocol == "-1" ? null : each.value.to_port
  referenced_security_group_id = each.value.referenced_security_group_id
  description                  = each.value.description
  tags                         = merge(module.labels.tags, each.value.tags)
}

resource "aws_vpc_security_group_ingress_rule" "new_sg_prefix" {
  for_each = var.enable && var.new_sg ? {
    for rule in var.new_sg_ingress_rules : rule.key => rule
    if rule.prefix_list_id != null
  } : {}
  security_group_id = local.new_sg_id
  ip_protocol       = each.value.ip_protocol
  from_port         = each.value.ip_protocol == "-1" ? null : each.value.from_port
  to_port           = each.value.ip_protocol == "-1" ? null : each.value.to_port
  prefix_list_id    = each.value.prefix_list_id
  description       = each.value.description
  tags              = merge(module.labels.tags, each.value.tags)
}

##-----------------------------------------------------------------------------
## Egress rules — new SG.
##-----------------------------------------------------------------------------
resource "aws_vpc_security_group_egress_rule" "new_sg_cidr" {
  for_each = var.enable && var.new_sg ? {
    for rule in var.new_sg_egress_rules : rule.key => rule
    if rule.cidr_ipv4 != null || rule.cidr_ipv6 != null
  } : {}
  security_group_id = local.new_sg_id
  ip_protocol       = each.value.ip_protocol
  from_port         = each.value.ip_protocol == "-1" ? null : each.value.from_port
  to_port           = each.value.ip_protocol == "-1" ? null : each.value.to_port
  cidr_ipv4         = each.value.cidr_ipv4
  cidr_ipv6         = each.value.cidr_ipv6
  description       = each.value.description
  tags              = merge(module.labels.tags, each.value.tags)
}

resource "aws_vpc_security_group_egress_rule" "new_sg_source_sg" {
  for_each = var.enable && var.new_sg ? {
    for rule in var.new_sg_egress_rules : rule.key => rule
    if rule.referenced_security_group_id != null
  } : {}
  security_group_id            = local.new_sg_id
  ip_protocol                  = each.value.ip_protocol
  from_port                    = each.value.ip_protocol == "-1" ? null : each.value.from_port
  to_port                      = each.value.ip_protocol == "-1" ? null : each.value.to_port
  referenced_security_group_id = each.value.referenced_security_group_id
  description                  = each.value.description
  tags                         = merge(module.labels.tags, each.value.tags)
}

resource "aws_vpc_security_group_egress_rule" "new_sg_prefix" {
  for_each = var.enable && var.new_sg ? {
    for rule in var.new_sg_egress_rules : rule.key => rule
    if rule.prefix_list_id != null
  } : {}
  security_group_id = local.new_sg_id
  ip_protocol       = each.value.ip_protocol
  from_port         = each.value.ip_protocol == "-1" ? null : each.value.from_port
  to_port           = each.value.ip_protocol == "-1" ? null : each.value.to_port
  prefix_list_id    = each.value.prefix_list_id
  description       = each.value.description
  tags              = merge(module.labels.tags, each.value.tags)
}

##-----------------------------------------------------------------------------
## Ingress/egress rules for an existing security group.
##-----------------------------------------------------------------------------
resource "aws_vpc_security_group_ingress_rule" "existing_sg_cidr" {
  for_each = var.enable && var.existing_sg_id != null ? {
    for rule in var.existing_sg_ingress_rules : rule.key => rule
    if rule.cidr_ipv4 != null || rule.cidr_ipv6 != null
  } : {}
  security_group_id = local.existing_sg_id
  ip_protocol       = each.value.ip_protocol
  from_port         = each.value.ip_protocol == "-1" ? null : each.value.from_port
  to_port           = each.value.ip_protocol == "-1" ? null : each.value.to_port
  cidr_ipv4         = each.value.cidr_ipv4
  cidr_ipv6         = each.value.cidr_ipv6
  description       = each.value.description
  tags              = merge(module.labels.tags, each.value.tags)
}

resource "aws_vpc_security_group_ingress_rule" "existing_sg_source_sg" {
  for_each = var.enable && var.existing_sg_id != null ? {
    for rule in var.existing_sg_ingress_rules : rule.key => rule
    if rule.referenced_security_group_id != null
  } : {}
  security_group_id            = local.existing_sg_id
  ip_protocol                  = each.value.ip_protocol
  from_port                    = each.value.ip_protocol == "-1" ? null : each.value.from_port
  to_port                      = each.value.ip_protocol == "-1" ? null : each.value.to_port
  referenced_security_group_id = each.value.referenced_security_group_id
  description                  = each.value.description
  tags                         = merge(module.labels.tags, each.value.tags)
}

resource "aws_vpc_security_group_egress_rule" "existing_sg_cidr" {
  for_each = var.enable && var.existing_sg_id != null ? {
    for rule in var.existing_sg_egress_rules : rule.key => rule
    if rule.cidr_ipv4 != null || rule.cidr_ipv6 != null
  } : {}
  security_group_id = local.existing_sg_id
  ip_protocol       = each.value.ip_protocol
  from_port         = each.value.ip_protocol == "-1" ? null : each.value.from_port
  to_port           = each.value.ip_protocol == "-1" ? null : each.value.to_port
  cidr_ipv4         = each.value.cidr_ipv4
  cidr_ipv6         = each.value.cidr_ipv6
  description       = each.value.description
  tags              = merge(module.labels.tags, each.value.tags)
}

resource "aws_vpc_security_group_egress_rule" "existing_sg_source_sg" {
  for_each = var.enable && var.existing_sg_id != null ? {
    for rule in var.existing_sg_egress_rules : rule.key => rule
    if rule.referenced_security_group_id != null
  } : {}
  security_group_id            = local.existing_sg_id
  ip_protocol                  = each.value.ip_protocol
  from_port                    = each.value.ip_protocol == "-1" ? null : each.value.from_port
  to_port                      = each.value.ip_protocol == "-1" ? null : each.value.to_port
  referenced_security_group_id = each.value.referenced_security_group_id
  description                  = each.value.description
  tags                         = merge(module.labels.tags, each.value.tags)
}
