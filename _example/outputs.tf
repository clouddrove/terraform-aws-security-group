output "tags" {
  value       = module.security_group.tags
  description = "A mapping of tags to assign to the resource."
}

output "security_group_ids" {
  value       = module.security_group.security_group_ids
  description = "A mapping of security group ids."
}
output "vpc_cidr_block" {
  value       = module.vpc.vpc_cidr_block
  description = "VPC IPV4 CIDR Block."
}

output "vpc_cidr_block_ipv6" {
  value       = module.vpc.ipv6_cidr_block
  description = "VPC IPV4 CIDR Block."
}