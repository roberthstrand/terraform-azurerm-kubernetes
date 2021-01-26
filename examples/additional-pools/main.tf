module "kubernetes" {
  source = "../../"
  # source  = "roberthstrand/kubernetes/azurerm"
  # version = "1.0.0-alpha1"

  name           = "demo"
  resource_group = azurerm_resource_group.cluster.name
  subnet_id      = azurerm_subnet.aks.id
  admin_groups   = data.azuread_groups.admins.object_ids

  # How to define a default pool, here with auto scaling enabled.
  default_node_pool = [{
    name                = "default"
    vm_size             = "Standard_D2s_v3"
    node_count          = 1
    enable_auto_scaling = false
    min_count           = null
    max_count           = null
    additional_settings = {
      max_pods        = 50
      os_disk_size_gb = 60
    }
  }]

  additional_node_pools = [
  {
    name                = "pool01"
    vm_size             = "Standard_B2s"
    node_count          = 1
    enable_auto_scaling = false
    min_count           = null
    max_count           = null
    node_labels         = {
      "type" = "burstable"
      }
    tags                = null
    additional_settings = {
      max_pods  = 30
    }
  }
  # ,
  # {
  #   name                = "pool02"
  #   vm_size             = "Standard_B2s"
  #   node_count          = null
  #   enable_auto_scaling = true
  #   min_count           = 2
  #   max_count           = 3
  #   node_labels         = {
  #     "type"      = "burstable"
  #     "autoscale" = "true"
  #     }
  #   tags                = null
  #   additional_settings = {
  #     mode      = "System"
  #     max_pods  = 30
  #   }
  # }
  ]

  namespaces = [
    {
      name = "space01"
      annotations = {
        source = "terraform"
      }
      labels = {
        environment = "production"
        app         = "business-app"
      }
    },
    {
      name = "space02"
      annotations = {
        source = "terraform"
      }
      labels = {
        environment = "production"
        app         = "business-app"
      }
    }
  ]

  depends_on = [azurerm_resource_group.cluster]
}
