## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| enable | Flag to control module creation. | `bool` | `true` | no |
| entry | Can be specified multiple times for each prefix list entry. | `list(any)` | `[]` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| existing\_sg\_egress\_rules\_with\_cidr\_blocks | Ingress rules with only cidr block. Should be used when there is existing security group. | `any` | `{}` | no |
| existing\_sg\_egress\_rules\_with\_prefix\_list | Egress rules with only prefic ist ids. Should be used when there is existing security group. | `any` | `{}` | no |
| existing\_sg\_egress\_rules\_with\_self | Egress rules with only self. Should be used when there is existing security group. | `any` | `{}` | no |
| existing\_sg\_egress\_rules\_with\_source\_sg\_id | Egress rules with only source security group id. Should be used when there is existing security group. | `any` | `{}` | no |
| existing\_sg\_id | Provide existing security group id for updating existing rule | `string` | `null` | no |
| existing\_sg\_ingress\_rules\_with\_cidr\_blocks | Ingress rules with only cidr blocks. Should be used when there is existing security group. | `any` | `{}` | no |
| existing\_sg\_ingress\_rules\_with\_prefix\_list | Ingress rules with only prefix\_list. Should be used when new security group is been deployed. | `any` | `{}` | no |
| existing\_sg\_ingress\_rules\_with\_self | Ingress rules with only source security group id. Should be used when new security group is been deployed. | `any` | `{}` | no |
| existing\_sg\_ingress\_rules\_with\_source\_sg\_id | Ingress rules with only prefix list ids. Should be used when there is existing security group. | `any` | `{}` | no |
| label\_order | Label order, e.g. `name`,`application`. | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| managedby | ManagedBy, eg 'CloudDrove'. | `string` | `"hello@clouddrove.com"` | no |
| max\_entries | The maximum number of entries that this prefix list can contain. | `number` | `5` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| new\_sg | Flag to control creation of new security group. | `bool` | `true` | no |
| new\_sg\_egress\_rules\_with\_cidr\_blocks | Egress rules with only cidr\_blockd. Should be used when new security group is been deployed. | `any` | `{}` | no |
| new\_sg\_egress\_rules\_with\_prefix\_list | Egress rules with only prefix list ids. Should be used when new security group is been deployed. | `any` | `{}` | no |
| new\_sg\_egress\_rules\_with\_self | Egress rules with only self. Should be used when new security group is been deployed. | `any` | `{}` | no |
| new\_sg\_egress\_rules\_with\_source\_sg\_id | Egress rules with only source security group id. Should be used when new security group is been deployed. | `any` | `{}` | no |
| new\_sg\_ingress\_rules\_with\_cidr\_blocks | Ingress rules with only cidr blocks. Should be used when new security group is been deployed. | `any` | `{}` | no |
| new\_sg\_ingress\_rules\_with\_prefix\_list | Ingress rules with only prefix list ids. Should be used when new security group is been deployed. | `any` | `{}` | no |
| new\_sg\_ingress\_rules\_with\_self | Ingress rules with only self. Should be used when new security group is been deployed. | `any` | `{}` | no |
| new\_sg\_ingress\_rules\_with\_source\_sg\_id | Ingress rules with only source security group id. Should be used when new security group is been deployed. | `any` | `{}` | no |
| prefix\_list\_address\_family | (Required, Forces new resource) The address family (IPv4 or IPv6) of prefix list. | `string` | `"IPv4"` | no |
| prefix\_list\_enabled | Enable prefix\_list. | `bool` | `false` | no |
| prefix\_list\_ids | The ID of the prefix list. | `list(string)` | `[]` | no |
| repository | Terraform current module repo | `string` | `"https://github.com/clouddrove/terraform-aws-security-group"` | no |
| sg\_description | Security group description. Defaults to Managed by Terraform. Cannot be empty string. NOTE: This field maps to the AWS GroupDescription attribute, for which there is no Update API. If you'd like to classify your security groups in a way that can be updated, use tags. | `string` | `null` | no |
| vpc\_id | The ID of the VPC that the instance security group belongs to. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| prefix\_list\_id | The ID of the prefix list. |
| security\_group\_arn | IDs on the AWS Security Groups associated with the instance. |
| security\_group\_id | IDs on the AWS Security Groups associated with the instance. |
| security\_group\_tags | A mapping of public tags to assign to the resource. |

