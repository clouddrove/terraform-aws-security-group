# Managed By : CloudDrove
# Description : This Script is used to create security group.
# Copyright @ CloudDrove. All Right Reserved.

#Module      : Label
#Description : This terraform module is designed to generate consistent label names and tags
#              for resources. You can use terraform-labels to implement a strict naming
#              convention.

module "labels" {
  source = "git::https://github.com/clouddrove/terraform-labels.git"

  name        = var.name
  application = var.application
  environment = var.environment
  label_order = var.label_order
}
locals {
  security_group_count = var.enable_security_group == true ? 1 : 0
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
  security_group_id = aws_security_group.default[0].id
}

#Module      : SECURITY GROUP RULE FOR INGRESS
#Description : Provides a security group rule resource. Represents a single ingress
#              group rule, which can be added to external Security Groups.
resource "aws_security_group_rule" "ingress" {
  count = var.enable_security_group == true ? length(compact(var.allowed_ports)) : 0

  type              = "ingress"
  from_port         = element(var.allowed_ports, count.index)
  to_port           = element(var.allowed_ports, count.index)
  protocol          = "tcp"
  cidr_blocks       = var.allowed_ip
  security_group_id = aws_security_group.default[0].id
}
