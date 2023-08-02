output "prefix_list_id" {
  value       = var.prefix_list_enabled && length(var.prefix_list_ids) < 1 ? aws_ec2_managed_prefix_list.prefix_list[0].id : null
  description = "The ID of the prefix list."
}

output "security_group_id" {
  value       = var.new_sg ? aws_security_group.default[0].id : null
  description = "IDs on the AWS Security Groups associated with the instance."
}

output "security_group_arn" {
  value       = var.new_sg ? aws_security_group.default[0].arn : null
  description = "IDs on the AWS Security Groups associated with the instance."
}

output "security_group_tags" {
  value       = var.new_sg ? aws_security_group.default[0].tags : null
  description = "A mapping of public tags to assign to the resource."
}