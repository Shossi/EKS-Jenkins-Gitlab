# Main Terraform Modules Documentation

## Project Directory Structure

```
.
|-- eks
|   |-- eks_only
|   |   |-- afterwards
|   |   |   |-- app.tf
|   |   |   `-- app.yaml
|   |   |-- main.tf
|   |   |-- output.tf
|   |   `-- provides.tf
|   |-- main.tf
|   |-- output.tf
|   `-- variables.tf
|-- helm
|   |-- main.tf
|   `-- variable.tf
|-- instance
|   |-- main.tf
|   |-- output.tf
|   `-- variables.tf
|-- instances.tf
|-- k8s.tf
|-- lb
|   |-- main.tf
|   |-- output.tf
|   `-- variables.tf
|-- modules
|   |-- eks
|   |   |-- main.tf
|   |   |-- output.tf
|   |   `-- variables.tf
|   |-- helm
|   |   |-- main.tf
|   |   |-- output.tf
|   |   `-- variable.tf
|   |-- iam_role_ingress
|   |   |-- main.tf
|   |   `-- variables.tf
|   |-- instance
|   |   |-- main.tf
|   |   |-- output.tf
|   |   `-- variables.tf
|   |-- lb
|   |   |-- main.tf
|   |   |-- output.tf
|   |   `-- variables.tf
|   |-- network
|   |   |-- main.tf
|   |   |-- output.tf
|   |   `-- variables.tf
|   |-- roles
|   |   |-- main.tf
|   |   |-- outputs.tf
|   |   `-- variables.tf
|   |-- security_groups
|   |   |-- main.tf
|   |   |-- output.tf
|   |   `-- variables.tf
|   `-- service_account
|       |-- main.tf
|       |-- output.tf
|       `-- variables.tf
|-- network
|   |-- main.tf
|   |-- output.tf
|   `-- variables.tf
|-- network.tf
|-- providers.tf
|-- roles
|   |-- main.tf
|   |-- outputs.tf
|   `-- variables.tf
|-- security_groups
|   |-- main.tf
|   |-- output.tf
|   `-- variables.tf
|-- vpc_eks
|   |-- k8s.tf
|   |-- network.tf
|   `-- providers.tf
`-- vpc_vcs_ci
    |-- instances.tf
    |-- network.tf
    |-- output.tf
    `-- providers.tf
```

## Table of Contents

- [eks](#eks)
- [eks_only](#eks_only)
- [helm](#helm)
- [instance](#instance)
- [lb](#lb)
- [network](#network)
- [roles](#roles)
- [security_groups](#security_groups)
- [vpc_eks](#vpc_eks)
- [vpc_vcs_ci](#vpc_vcs_ci)


## eks

---

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | terraform-aws-modules/eks/aws | ~> 19.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_endpoint_private_access"></a> [cluster\_endpoint\_private\_access](#input\_cluster\_endpoint\_private\_access) | Enable private access to the cluster endpoint | `bool` | `true` | no |
| <a name="input_cluster_endpoint_public_access"></a> [cluster\_endpoint\_public\_access](#input\_cluster\_endpoint\_public\_access) | Enable public access to the cluster endpoint | `bool` | `true` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the EKS cluster | `string` | n/a | yes |
| <a name="input_eks_tags"></a> [eks\_tags](#input\_eks\_tags) | Tags for the EKS cluster | `map(string)` | <pre>{<br>  "Environment": "prod"<br>}</pre> | no |
| <a name="input_enable_irsa"></a> [enable\_irsa](#input\_enable\_irsa) | Enable IAM Roles for Service Accounts (IRSA) | `bool` | `false` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | List of subnet IDs for the EKS cluster | `list(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_auth"></a> [cluster\_auth](#output\_cluster\_auth) | n/a |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | n/a |
| <a name="output_cluster_security_group_id"></a> [cluster\_security\_group\_id](#output\_cluster\_security\_group\_id) | The security group ID of the EKS cluster control plane |
| <a name="output_eks_cluster_endpoint"></a> [eks\_cluster\_endpoint](#output\_eks\_cluster\_endpoint) | Endpoint of the EKS cluster |
| <a name="output_eks_cluster_id"></a> [eks\_cluster\_id](#output\_eks\_cluster\_id) | ID of the EKS cluster |


## eks_only

---

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.5.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.6.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.7.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | >= 2.6.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.57.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.14.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_k8s"></a> [k8s](#module\_k8s) | ../ | n/a |
| <a name="module_prod_network"></a> [prod\_network](#module\_prod\_network) | ../../network | n/a |

## Resources

| Name | Type |
|------|------|
| [helm_release.argocd](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [aws_eks_cluster_auth.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_certificate_auth"></a> [cluster\_certificate\_auth](#output\_cluster\_certificate\_auth) | n/a |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | The endpoint for your EKS cluster |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | n/a |
| <a name="output_eks_token"></a> [eks\_token](#output\_eks\_token) | n/a |


## helm

---

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.argocd](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_manifest.argo_app](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_depends"></a> [depends](#input\_depends) | n/a | `any` | n/a | yes |

## Outputs

No outputs.


## instance

---

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_instance.instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami"></a> [ami](#input\_ami) | n/a | `any` | n/a | yes |
| <a name="input_iam_instance_profile"></a> [iam\_instance\_profile](#input\_iam\_instance\_profile) | The IAM instance profile | `string` | `null` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | n/a | `any` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | n/a | `any` | n/a | yes |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | n/a | `any` | n/a | yes |
| <a name="input_sec_group_id"></a> [sec\_group\_id](#input\_sec\_group\_id) | n/a | `any` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | n/a |


## lb

---

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_lb.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.gitlab_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.gitlab_tg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group.jenkins_tg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.gitlab_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_lb_target_group_attachment.jenkins_targets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_security_group.lb_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_gitlab_instance_id"></a> [gitlab\_instance\_id](#input\_gitlab\_instance\_id) | Gitlab instance ID | `string` | n/a | yes |
| <a name="input_internal"></a> [internal](#input\_internal) | Whether the load balancer is internal | `bool` | `false` | no |
| <a name="input_jenkins_instance_ids"></a> [jenkins\_instance\_ids](#input\_jenkins\_instance\_ids) | List of Jenkins instance IDs | `list(string)` | n/a | yes |
| <a name="input_load_balancer_name"></a> [load\_balancer\_name](#input\_load\_balancer\_name) | Name of the load balancer | `string` | n/a | yes |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | List of public subnets to deploy the load balancer | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to assign to the load balancer | `map(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID where the load balancer will be deployed | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lb_arn"></a> [lb\_arn](#output\_lb\_arn) | The ARN of the load balancer |
| <a name="output_lb_dns_name"></a> [lb\_dns\_name](#output\_lb\_dns\_name) | The DNS name of the load balancer |
| <a name="output_lb_sg_id"></a> [lb\_sg\_id](#output\_lb\_sg\_id) | The ID of the load balancer security group |
| <a name="output_lb_target_group_arn"></a> [lb\_target\_group\_arn](#output\_lb\_target\_group\_arn) | The ARN of the target group |


## network

---

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azs"></a> [azs](#input\_azs) | A list of availability zones specified as argument to this module | `list(string)` | <pre>[<br>  "eu-west-3a",<br>  "eu-west-3b",<br>  "eu-west-3c"<br>]</pre> | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | A list of private subnets inside the VPC | `list(string)` | <pre>[<br>  "10.0.1.0/24",<br>  "10.0.2.0/24",<br>  "10.0.3.0/24"<br>]</pre> | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | A list of public subnets inside the VPC | `list(string)` | <pre>[<br>  "10.0.101.0/24",<br>  "10.0.102.0/24",<br>  "10.0.103.0/24"<br>]</pre> | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name to be used on all the resources as identifier | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_subnet_cidr"></a> [private\_subnet\_cidr](#output\_private\_subnet\_cidr) | n/a |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | Private subnets |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | Public subnets |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | ID of the VPC |


## roles

---

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.cloudwatch_agent_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_instance_profile.jenkins_agent_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.cloudwatch_agent_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.cloudwatch_agent_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.jenkins_agent_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.attach_cloudwatch_agent_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecr_readonly_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_cluster_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_cni_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.eks_worker_node_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudwatch_instance_profile_name"></a> [cloudwatch\_instance\_profile\_name](#input\_cloudwatch\_instance\_profile\_name) | The name of the IAM instance profile | `string` | `"CloudWatch-agent-instance-profile"` | no |
| <a name="input_cloudwatch_role_name"></a> [cloudwatch\_role\_name](#input\_cloudwatch\_role\_name) | The name of the IAM role | `string` | `"Cloudwatch-agent-role"` | no |
| <a name="input_eks_instance_profile_name"></a> [eks\_instance\_profile\_name](#input\_eks\_instance\_profile\_name) | The name of the IAM instance profile | `string` | `"jenkins-agent-instance-profile"` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | The name of the IAM role | `string` | `"jenkins-agent-role"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_jenkins_agent_instance_profile_name"></a> [jenkins\_agent\_instance\_profile\_name](#output\_jenkins\_agent\_instance\_profile\_name) | n/a |


## security_groups

---

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_security_group.sec_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Description of the security group | `string` | n/a | yes |
| <a name="input_egress_rules"></a> [egress\_rules](#input\_egress\_rules) | List of egress rules | <pre>list(object({<br>    from_port   = number<br>    to_port     = number<br>    protocol    = string<br>    cidr_blocks = list(string)<br>  }))</pre> | <pre>[<br>  {<br>    "cidr_blocks": [<br>      "0.0.0.0/0"<br>    ],<br>    "from_port": 0,<br>    "protocol": "-1",<br>    "to_port": 0<br>  }<br>]</pre> | no |
| <a name="input_extra_ingress_rules"></a> [extra\_ingress\_rules](#input\_extra\_ingress\_rules) | Extra ingress rules for the security group | <pre>list(object({<br>    from_port        = number<br>    to_port          = number<br>    protocol         = string<br>    security_groups  = list(string)<br>    cidr_blocks      = list(string)<br>    ipv6_cidr_blocks = list(string)<br>    prefix_list_ids  = list(string)<br>    self             = bool<br>  }))</pre> | `[]` | no |
| <a name="input_ingress_rules"></a> [ingress\_rules](#input\_ingress\_rules) | Ingress rules for the security group | <pre>list(object({<br>    from_port   = number<br>    to_port     = number<br>    protocol    = string<br>    cidr_blocks = list(string)<br>  }))</pre> | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the security group | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to assign to the security group | `map(string)` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | The VPC ID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group |


## vpc_eks

---

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.5.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.6.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.5.0 |
| <a name="provider_http"></a> [http](#provider\_http) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_argocd"></a> [argocd](#module\_argocd) | ../modules/helm | n/a |
| <a name="module_cluster_autoscaler"></a> [cluster\_autoscaler](#module\_cluster\_autoscaler) | ../modules/helm | n/a |
| <a name="module_cluster_autoscaler_service_account"></a> [cluster\_autoscaler\_service\_account](#module\_cluster\_autoscaler\_service\_account) | ../modules/cluster-autoscaler | n/a |
| <a name="module_iam_role_ingress"></a> [iam\_role\_ingress](#module\_iam\_role\_ingress) | ../modules/iam_role_ingress | n/a |
| <a name="module_ingress_controller"></a> [ingress\_controller](#module\_ingress\_controller) | ../modules/helm | n/a |
| <a name="module_k8s"></a> [k8s](#module\_k8s) | ../modules/eks | n/a |
| <a name="module_prod_network"></a> [prod\_network](#module\_prod\_network) | ../modules/network | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_eks_cluster_auth.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |
| [http_http.ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_public_key_path"></a> [public\_key\_path](#input\_public\_key\_path) | Path to the SSH public key | `string` | `"/home/yossi/.ssh/new_key.pub"` | no |

## Outputs

No outputs.


## vpc_vcs_ci

---

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.5.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | >= 2.6.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.5.0 |
| <a name="provider_http"></a> [http](#provider\_http) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bastion"></a> [bastion](#module\_bastion) | ../modules/instance | n/a |
| <a name="module_bastion_sg"></a> [bastion\_sg](#module\_bastion\_sg) | ../modules/security_groups | n/a |
| <a name="module_default_sg"></a> [default\_sg](#module\_default\_sg) | ../modules/security_groups | n/a |
| <a name="module_dev_network"></a> [dev\_network](#module\_dev\_network) | ../modules/network | n/a |
| <a name="module_gitlab"></a> [gitlab](#module\_gitlab) | ../modules/instance | n/a |
| <a name="module_jenkins"></a> [jenkins](#module\_jenkins) | ../modules/instance | n/a |
| <a name="module_jenkins_agent"></a> [jenkins\_agent](#module\_jenkins\_agent) | ../modules/instance | n/a |
| <a name="module_jenkins_agent_iam_role"></a> [jenkins\_agent\_iam\_role](#module\_jenkins\_agent\_iam\_role) | ../modules/roles | n/a |
| <a name="module_lb"></a> [lb](#module\_lb) | ../modules/lb | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_key_pair.deployer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [http_http.ip](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_public_key_path"></a> [public\_key\_path](#input\_public\_key\_path) | Path to the SSH public key | `string` | `"/home/yossi/.ssh/new_key.pub"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lb_url"></a> [lb\_url](#output\_lb\_url) | n/a |
