## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| enable | Flag to control module creation. | `bool` | `true` | no |
| entry | Entries for the managed prefix list. | `list(any)` | `[]` | no |
| environment | Environment (e.g. prod, dev, staging). | `string` | `""` | no |
| existing\_sg\_egress\_rules | Egress rules to add to an existing security group (requires existing\_sg\_id). | <pre>list(object({<br>    key                          = string<br>    ip_protocol                  = string<br>    from_port                    = optional(number)<br>    to_port                      = optional(number)<br>    cidr_ipv4                    = optional(string)<br>    cidr_ipv6                    = optional(string)<br>    prefix_list_id               = optional(string)<br>    referenced_security_group_id = optional(string)<br>    description                  = optional(string, "Managed by Terraform")<br>    tags                         = optional(map(string), {})<br>  }))</pre> | `[]` | no |
| existing\_sg\_id | ID of a pre-existing security group to add rules to. | `string` | `null` | no |
| existing\_sg\_ingress\_rules | Ingress rules to add to an existing security group (requires existing\_sg\_id). | <pre>list(object({<br>    key                          = string<br>    ip_protocol                  = string<br>    from_port                    = optional(number)<br>    to_port                      = optional(number)<br>    cidr_ipv4                    = optional(string)<br>    cidr_ipv6                    = optional(string)<br>    prefix_list_id               = optional(string)<br>    referenced_security_group_id = optional(string)<br>    description                  = optional(string, "Managed by Terraform")<br>    tags                         = optional(map(string), {})<br>  }))</pre> | `[]` | no |
| label\_order | Label order. | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| managedby | ManagedBy, eg 'CloudDrove'. | `string` | `"hello@clouddrove.com"` | no |
| max\_entries | Maximum entries in the managed prefix list. | `number` | `5` | no |
| name | Name (e.g. app or cluster). | `string` | `""` | no |
| new\_sg | Create a new security group. Set false to manage rules on an existing SG via existing\_sg\_id. | `bool` | `true` | no |
| new\_sg\_egress\_rules | Egress rules for the newly created security group. Default allows all IPv4 egress. | <pre>list(object({<br>    key                          = string<br>    ip_protocol                  = string<br>    from_port                    = optional(number)<br>    to_port                      = optional(number)<br>    cidr_ipv4                    = optional(string)<br>    cidr_ipv6                    = optional(string)<br>    prefix_list_id               = optional(string)<br>    referenced_security_group_id = optional(string)<br>    description                  = optional(string, "Managed by Terraform")<br>    tags                         = optional(map(string), {})<br>  }))</pre> | <pre>[<br>  {<br>    "cidr_ipv4": "0.0.0.0/0",<br>    "description": "Allow all IPv4 egress",<br>    "ip_protocol": "-1",<br>    "key": "allow-all-ipv4-egress"<br>  }<br>]</pre> | no |
| new\_sg\_ingress\_rules | Ingress rules for the newly created security group. | <pre>list(object({<br>    key                          = string<br>    ip_protocol                  = string<br>    from_port                    = optional(number)<br>    to_port                      = optional(number)<br>    cidr_ipv4                    = optional(string)<br>    cidr_ipv6                    = optional(string)<br>    prefix_list_id               = optional(string)<br>    referenced_security_group_id = optional(string)<br>    description                  = optional(string, "Managed by Terraform")<br>    tags                         = optional(map(string), {})<br>  }))</pre> | `[]` | no |
| prefix\_list\_address\_family | Address family for the managed prefix list: IPv4 or IPv6. | `string` | `"IPv4"` | no |
| prefix\_list\_enabled | Create a managed prefix list. | `bool` | `false` | no |
| prefix\_list\_ids | Existing prefix list IDs to reference in rules. If empty and prefix\_list\_enabled=true, a new one is created. | `list(string)` | `[]` | no |
| repository | Terraform current module repo. | `string` | `"https://github.com/clouddrove/terraform-aws-security-group"` | no |
| revoke\_rules\_on\_delete | Revoke all rules before deleting the SG. Required for EMR and similar services that inject their own rules. | `bool` | `false` | no |
| sg\_description | Security group description. Cannot be updated in-place — forces replacement. | `string` | `"Managed by Terraform"` | no |
| tags | Additional tags. | `map(string)` | `{}` | no |
| vpc\_id | VPC ID the security group belongs to. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| prefix\_list\_id | ID of the managed prefix list, if created. |
| security\_group\_arn | ARN of the created security group. |
| security\_group\_id | ID of the created security group. |
| security\_group\_name | Name of the created security group. |
| security\_group\_tags | Tags applied to the security group. |

