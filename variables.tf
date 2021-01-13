variable "name" {
  type        = string
  description = "Name the deployment."
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "Tags that will be used for the deployment."
}

variable "resource_group" {
  type        = string
  description = "The resource group you want your deployment in."
}

variable "subnet_id" {
  type        = string
  description = "The object ID of the subnet that you want to deploy to"
}

variable "location" {
  type        = string
  description = "The location you want to deployment in, defaults to the location of the resource group."
  default     = "not_set"
}

variable "kubernetes_version" {
  type        = string
  description = "The Kubernetes version the cluster should run. Defaults to the latest version available."
  default     = "not_set"
}

variable "kubernetes_version_prefix" {
  type        = string
  description = "Set a prefix for the Kubernetes version. Example: 1.17 uses the latest version of 1.17."
  default     = "1.19"
}
variable "kubernetes_include_preview" {
  type        = bool
  description = "Include versions of Kubernetes that are released as 'preview'. Defaults to false."
  default     = false
}

variable "enable_kube_dashboard" {
  type        = bool
  description = "Whether or not the Kubernetes dashboard should be enabled. Defaults to false."
  default     = false
}

variable "enable_azure_policy" {
  type        = bool
  description = "Enable the usage of Azure Policy for Kubernetes. Enabled by default."
  default     = true
}

variable "enable_oms_agent" {
  type        = bool
  default     = false
  description = "Enable the OMS agent, for use with Azure Monitor."
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "The id for the log analytics workspace the cluster should use."
  default     = null
}

variable "network_plugin" {
  type        = string
  description = "Set to kubenet by default, can be either kubenet or azure."
  default     = "kubenet"
}

variable "network_policy" {
  type        = string
  description = "Sets up network policy to be used. Either Azure or Calico. Azure is only supported using Azure CNI."
  default     = "calico"
}

variable "outbound_type" {
  type        = string
  description = "The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer and userDefinedRouting."
  default     = "loadBalancer"
}

variable "pod_cidr" {
  type        = string
  description = "When using the kubenet network plugin, a CIDR needs to be set for pod IP addresses."
  default     = "192.168.0.0/24"
}

variable "service_cidr" {
  type        = string
  description = "The Network Range used by the Kubernetes service"
  default     = "10.10.0.0/16"
}

variable "dns_service_ip" {
  type        = string
  description = "IP address within the Kubernetes service address range that will be used by kube-dns."
  default     = "10.10.0.10"
}

variable "docker_bridge_cidr" {
  type        = string
  description = "CIDR used as the Docker bridge IP address on nodes."
  default     = "172.17.0.1/16"
}

variable "role_based_access_control" {
  type        = bool
  description = "Whether or not RBAC is enabled on the cluster."
  default     = true
}

variable "azure_ad_managed" {
  type        = bool
  description = "Is the Azure Active Directory integration Managed, meaning that Azure will create/manage the Service Principal used for integration?"
  default     = true
}
variable "admin_groups" {
  type        = list(string)
  description = "A list of object IDs of Azure AD groups that should have the admin role in the cluster."
  default     = null
}

variable "rbac_client_app_id" {
  type        = string
  default     = null
  description = "The Client ID of an Azure Active Directory Application."
}
variable "rbac_server_app_id" {
  type        = string
  default     = null
  description = "The Server ID of an Azure Active Directory Application."
}
variable "rbac_server_app_secret" {
  type        = string
  default     = null
  description = "The Server Secret of an Azure Active Directory Application."
}

variable "sp_client_id" {
  type    = string
  default = null
}
variable "sp_client_secret" {
  type    = string
  default = null
}
variable "default_node_pool" {
  type = list(object({
    name                = string
    vm_size             = string
    node_count          = number
    enable_auto_scaling = bool
    min_count           = number
    max_count           = number
    node_taints         = string
  }))
  default = [
    {
      name                = "default"
      vm_size             = "Standard_D2s_v3"
      node_count          = 1
      enable_auto_scaling = false
      min_count           = null
      max_count           = null
      node_taints         = ""
    }
  ]
}
variable "additional_node_pools" {
  type = list(object({
    name                = string
    vm_size             = string
    node_count          = number
    enable_auto_scaling = bool
    min_count           = number
    max_count           = number
    node_labels         = map(string)
    node_taints         = any
    tags                = map(string)
  }))
  default = []
}