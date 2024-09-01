# Main Terraform Modules Documentation

## Project Directory Structure

```
.
|-- eks
|   `-- eks_only
|-- instances.tf
|-- k8s.tf
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
|-- network.tf
|-- providers.tf
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
- [vpc_eks](#vpc_eks)
- [vpc_vcs_ci](#vpc_vcs_ci)


## eks

---

## Requirements

No requirements.

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.


## eks_only

---

## Requirements

No requirements.

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.


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
