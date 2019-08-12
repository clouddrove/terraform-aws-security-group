#Module      : SECURITY GROUP
#Description : This terraform module creates set of Security Group and Security Group Rules
#              resources in various combinations.
output "security_group_ids" {
  value = concat(
    aws_security_group.default.*.id
  )[0]
  description = "IDs on the AWS Security Groups associated with the instance."
}

output "tags" {
  value       = module.labels.tags
  description = "A mapping of public tags to assign to the resource."
}