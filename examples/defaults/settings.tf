terraform {
  required_providers {
    azurerm = {
      version = "=2.40.0"
    }
    azuread = {
      version = "=0.7.0"
    }
  }
}
provider "azurerm" {
  features {}
}

provider "kubernetes" {
  load_config_file = "false"

  host = module.kubernetes.host

  client_certificate     = module.kubernetes.client_certificate
  client_key             = module.kubernetes.client_key
  cluster_ca_certificate = module.kubernetes.cluster_ca_certificate
}

resource "azurerm_resource_group" "cluster" {
  name     = "cluster-rg"
  location = "West Europe"
}

resource "azurerm_virtual_network" "cluster" {
  name                = "Cluster-vnet"
  location            = azurerm_resource_group.cluster.location
  resource_group_name = azurerm_resource_group.cluster.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "aks" {
  name                 = "aks"
  resource_group_name  = azurerm_resource_group.cluster.name
  virtual_network_name = azurerm_virtual_network.cluster.name
  address_prefixes     = ["10.0.0.0/24"]
}

data "azuread_groups" "admins" {
  names = ["aks-admin"]
}