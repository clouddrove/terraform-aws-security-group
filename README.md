<!-- This file was automatically generated by the `geine`. Make all changes to `README.yaml` and run `make readme` to rebuild this file. -->

<p align="center"> <img src="https://user-images.githubusercontent.com/50652676/62349836-882fef80-b51e-11e9-99e3-7b974309c7e3.png" width="100" height="100"></p>


<h1 align="center">
    Terraform AWS Security Group
</h1>

<p align="center" style="font-size: 1.2rem;">
    This terraform module creates set of Security Group and Security Group Rules resources in various combinations.
     </p>

<p align="center">

<a href="https://www.terraform.io">
  <img src="https://img.shields.io/badge/terraform-v0.15-green" alt="Terraform">
</a>
<a href="LICENSE.md">
  <img src="https://img.shields.io/badge/License-MIT-blue.svg" alt="Licence">
</a>


</p>
<p align="center">

<a href='https://facebook.com/sharer/sharer.php?u=https://github.com/clouddrove/terraform-aws-security-group'>
  <img title="Share on Facebook" src="https://user-images.githubusercontent.com/50652676/62817743-4f64cb80-bb59-11e9-90c7-b057252ded50.png" />
</a>
<a href='https://www.linkedin.com/shareArticle?mini=true&title=Terraform+AWS+Security+Group&url=https://github.com/clouddrove/terraform-aws-security-group'>
  <img title="Share on LinkedIn" src="https://user-images.githubusercontent.com/50652676/62817742-4e339e80-bb59-11e9-87b9-a1f68cae1049.png" />
</a>
<a href='https://twitter.com/intent/tweet/?text=Terraform+AWS+Security+Group&url=https://github.com/clouddrove/terraform-aws-security-group'>
  <img title="Share on Twitter" src="https://user-images.githubusercontent.com/50652676/62817740-4c69db00-bb59-11e9-8a79-3580fbbf6d5c.png" />
</a>

</p>
<hr>


We eat, drink, sleep and most importantly love **DevOps**. We are working towards strategies for standardizing architecture while ensuring security for the infrastructure. We are strong believer of the philosophy <b>Bigger problems are always solved by breaking them into smaller manageable problems</b>. Resonating with microservices architecture, it is considered best-practice to run database, cluster, storage in smaller <b>connected yet manageable pieces</b> within the infrastructure.

This module is basically combination of [Terraform open source](https://www.terraform.io/) and includes automatation tests and examples. It also helps to create and improve your infrastructure with minimalistic code instead of maintaining the whole infrastructure code yourself.

We have [*fifty plus terraform modules*][terraform_modules]. A few of them are comepleted and are available for open source usage while a few others are in progress.




## Prerequisites

This module has a few dependencies:

- [Terraform 0.13](https://learn.hashicorp.com/terraform/getting-started/install.html)
- [Go](https://golang.org/doc/install)
- [github.com/stretchr/testify/assert](https://github.com/stretchr/testify)
- [github.com/gruntwork-io/terratest/modules/terraform](https://github.com/gruntwork-io/terratest)







## Examples


**IMPORTANT:** Since the `master` branch used in `source` varies based on new modifications, we suggest that you use the release versions [here](https://github.com/clouddrove/terraform-aws-security-group/releases).


### Simple Example
Here is an example of how you can use this module in your inventory structure:
```hcl
# use this
  module "security_group" {
    source        = "clouddrove/security-group/aws"
    version       = "0.15.0"
    name          = "security-group"
    environment   = "test"
    protocol      = "tcp"
    label_order   = ["name", "environment"]
    vpc_id        = "vpc-xxxxxxxxx"
    allowed_ip    = ["172.16.0.0/16", "10.0.0.0/16"]
    allowed_ipv6  = ["2405:201:5e00:3684:cd17:9397:5734:a167/128"]
    allowed_ports = [22, 27017]
  }
```






## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allowed\_ip | List of allowed ip. | `list(any)` | `[]` | no |
| allowed\_ipv6 | List of allowed ipv6. | `list(any)` | `[]` | no |
| allowed\_ports | List of allowed ingress ports | `list(any)` | `[]` | no |
| attributes | Additional attributes (e.g. `1`). | `list(any)` | `[]` | no |
| description | The security group description. | `string` | `"Instance default security group (only egress access is allowed)."` | no |
| egress\_allowed\_ip | List of allowed ip. | `list(any)` | `[]` | no |
| egress\_allowed\_ipv6 | List of allowed ipv6. | `list(any)` | `[]` | no |
| egress\_allowed\_ports | List of allowed ingress ports | `list(any)` | `[]` | no |
| egress\_prefix\_list\_ids | List of prefix list IDs (for allowing access to VPC endpoints)Only valid with egress | `list(any)` | `[]` | no |
| egress\_protocol | The protocol. If not icmp, tcp, udp, or all use the. | `string` | `"tcp"` | no |
| egress\_rule | Enable to create egress rule | `bool` | `false` | no |
| egress\_security\_groups | List of Security Group IDs allowed to connect to the instance. | `list(string)` | `[]` | no |
| enable\_security\_group | Enable default Security Group with only Egress traffic allowed. | `bool` | `true` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| existing\_sg\_id | Provide existing security group id for updating existing rule | `string` | `null` | no |
| is\_external | enable to udated existing security Group | `bool` | `false` | no |
| label\_order | Label order, e.g. `name`,`application`. | `list(any)` | `[]` | no |
| managedby | ManagedBy, eg 'CloudDrove'. | `string` | `"hello@clouddrove.com"` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| prefix\_list | List of prefix list IDs (for allowing access to VPC endpoints)Only valid with egress | `list(any)` | `[]` | no |
| prefix\_list\_ids | Provide allow source Prefix id of resources | `list(string)` | `[]` | no |
| protocol | The protocol. If not icmp, tcp, udp, or all use the. | `string` | `"tcp"` | no |
| repository | Terraform current module repo | `string` | `"https://registry.terraform.io/modules/clouddrove/security-group/aws/"` | no |
| security\_groups | List of Security Group IDs allowed to connect to the instance. | `list(string)` | `[]` | no |
| tags | Additional tags (e.g. map(`BusinessUnit`,`XYZ`). | `map(string)` | `{}` | no |
| vpc\_id | The ID of the VPC that the instance security group belongs to. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| security\_group\_ids | IDs on the AWS Security Groups associated with the instance. |
| tags | A mapping of public tags to assign to the resource. |




## Testing
In this module testing is performed with [terratest](https://github.com/gruntwork-io/terratest) and it creates a small piece of infrastructure, matches the output like ARN, ID and Tags name etc and destroy infrastructure in your AWS account. This testing is written in GO, so you need a [GO environment](https://golang.org/doc/install) in your system.

You need to run the following command in the testing folder:
```hcl
  go test -run Test
```



## Feedback
If you come accross a bug or have any feedback, please log it in our [issue tracker](https://github.com/clouddrove/terraform-aws-security-group/issues), or feel free to drop us an email at [hello@clouddrove.com](mailto:hello@clouddrove.com).

If you have found it worth your time, go ahead and give us a ★ on [our GitHub](https://github.com/clouddrove/terraform-aws-security-group)!

## About us

At [CloudDrove][website], we offer expert guidance, implementation support and services to help organisations accelerate their journey to the cloud. Our services include docker and container orchestration, cloud migration and adoption, infrastructure automation, application modernisation and remediation, and performance engineering.

<p align="center">We are <b> The Cloud Experts!</b></p>
<hr />
<p align="center">We ❤️  <a href="https://github.com/clouddrove">Open Source</a> and you can check out <a href="https://github.com/clouddrove">our other modules</a> to get help with your new Cloud ideas.</p>

  [website]: https://clouddrove.com
  [github]: https://github.com/clouddrove
  [linkedin]: https://cpco.io/linkedin
  [twitter]: https://twitter.com/clouddrove/
  [email]: https://clouddrove.com/contact-us.html
  [terraform_modules]: https://github.com/clouddrove?utf8=%E2%9C%93&q=terraform-&type=&language=
