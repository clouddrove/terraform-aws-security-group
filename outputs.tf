output "security_group_ids" {
  description = "IDs on the AWS Security Groups associated with the instance"
  value       = "${compact(concat(list(var.create_default_security_group == "true" ? join("", aws_security_group.default.*.id) : ""), var.security_groups))}"
}
