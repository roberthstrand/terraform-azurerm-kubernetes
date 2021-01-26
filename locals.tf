# locals {
#   kubernetes_version = var.kubernetes_version == "not_set" ? data.azurerm_kubernetes_service_versions.current.latest_version : var.kubernetes_version
# }
