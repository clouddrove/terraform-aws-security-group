output "security_group_id" {
  value       = var.enable && var.new_sg ? aws_security_group.default[0].id : null
  description = "ID of the created security group."
}

output "security_group_arn" {
  value       = var.enable && var.new_sg ? aws_security_group.default[0].arn : null
  description = "ARN of the created security group."
}

output "security_group_name" {
  value       = var.enable && var.new_sg ? aws_security_group.default[0].name : null
  description = "Name of the created security group."
}

output "security_group_tags" {
  value       = var.enable && var.new_sg ? aws_security_group.default[0].tags : null
  description = "Tags applied to the security group."
}

output "prefix_list_id" {
  value       = var.enable && var.prefix_list_enabled && length(var.prefix_list_ids) < 1 ? aws_ec2_managed_prefix_list.prefix_list[0].id : null
  description = "ID of the managed prefix list, if created."
}
