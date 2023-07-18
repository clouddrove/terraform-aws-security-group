output "tags" {
  value       = module.security_group.tags
  description = "A mapping of tags to assign to the resource."
}

output "security_group_ids" {
  value       = module.security_group.security_group_ids
  description = "A mapping of security group ids."
}

output "prefix_id" {
  value = module.prefix_list.*.prefix_id
}