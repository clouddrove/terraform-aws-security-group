output "prefix_id" {
  value       = aws_ec2_managed_prefix_list.prefix_list_sg_example.*.id
  description = "The ID of the prefix list."
}