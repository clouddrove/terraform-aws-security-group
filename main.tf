locals {
  security_group_count = "${var.create_default_security_group == "true" ? 1 : 0}"
}

module "labels" {
  source      = "git::https://github.com/clouddrove/terraform-lables.git?ref=tags/0.11.0"
  application = "${var.application}"
  name        = "${var.name}"
  environment = "${var.environment}"
}

resource "aws_security_group" "default" {
  count       = "${local.security_group_count}"
  name        = "${module.labels.id}"
  vpc_id      = "${var.vpc_id}"
  description = "Instance default security group (only egress access is allowed)"
  tags        = "${module.labels.tags}"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "egress" {
  count             = "${var.create_default_security_group == "true" ? 1 : 0}"
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.default.id}"
}

resource "aws_security_group_rule" "ingress" {
  count             = "${var.create_default_security_group == "true" ? length(compact(var.allowed_ports)) : 0}"
  type              = "ingress"
  from_port         = "${element(var.allowed_ports, count.index)}"
  to_port           = "${element(var.allowed_ports, count.index)}"
  protocol          = "tcp"
  cidr_blocks       = ["${var.cidr_blocks}"]
  security_group_id = "${aws_security_group.default.id}"
}
