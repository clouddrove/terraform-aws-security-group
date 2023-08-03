output "security_group_tags" {
  value       = module.security_group.security_group_tags
  description = "A mapping of tags to assign to the resource."
}

output "security_group_id" {
  value       = module.security_group.security_group_id
  description = "A mapping of security group ids."
}

output "preifx_list_id" {
  value       = module.security_group.prefix_list_id
  description = "A mapping of security group ids."
}


