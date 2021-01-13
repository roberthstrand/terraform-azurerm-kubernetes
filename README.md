# Terraform module for Azure Kubernetes Service
A flexible module for deploying AKS clusters. The main purpose for this module, besides being the basis for doing talks about Terraform, is to enable users to deploy clusters that adhere to industry standards but that is flexible enough so that anyone can use it for whatever type of deployment.

[![test](https://github.com/roberthstrand/terraform-azurerm-kubernetes/workflows/test/badge.svg?branch=main)](https://github.com/roberthstrand/terraform-azurerm-kubernetes/actions?query=workflow%3Atest)

## Requirements

| Provider | Minimum version | Note
| -------- | --------------- | ---- |
| azurerm | 2.40.0 | Still requires the features field. Read the [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#example-usage) if in doubt. |
| kubernetes | 1.13.3 | See the [Kubernetes provider](#kubernetes-provider) section. |

### admin_groups needed
By default the module deploys the cluster as managed, with RBAC. This means that you will have to define what group(s) that will have administrator access to the cluster. This is done through the input variable `admin_groups`, which expects a list of object IDs. You could copy the IDs from the portal and set it explicit, but I like using the data source `azuread_groups` as it returns object IDs of one or more group based on names.

Example using `azuread_groups` can be found [here](https://github.com/roberthstrand/terraform-azurerm-kubernetes/examples/defaults), psuedo code below.

```hcl
data "azuread_groups" "admins" {
  names = ["group01", "group02"]
}

module "kubernetes" {
  source  = "roberthstrand/kubernetes/azurerm"
  version = "1.0.0"

  admin_groups = data.azuread_groups.admins.object_ids
}
```

### Kubernetes provider

A static version can be set, as long as it's above the minimum version specified above. The module uses the Kubernetes provider for adding namespaces, but if you don't need to create that through the module feel free not to include the provider block below. The reason

```hcl
provider "kubernetes" {
  load_config_file = "false"

  host = module.kubernetes.host

  client_certificate     = module.kubernetes.client_certificate
  client_key             = module.kubernetes.client_key
  cluster_ca_certificate = module.kubernetes.cluster_ca_certificate
}
```