resource "kubernetes_namespace" "example" {
  for_each = { for ns in var.namespaces : ns.name => ns }
  metadata {
    name        = each.value.name
    annotations = each.value.annotations
    labels      = each.value.labels
  }
}
