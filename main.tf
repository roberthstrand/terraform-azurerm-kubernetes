terraform {
  required_providers {
    azurerm = {
      version = ">=2.40.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">=1.13.3"
    }
  }
}