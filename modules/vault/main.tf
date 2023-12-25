resource "helm_release" "vault" {
  name       = var.name
  chart      = "vault"
  repository = "https://helm.releases.hashicorp.com"
  version    = var.chart_version
  namespace  = var.namespace

  values = [
    file("${path.module}/data/values.yaml")
  ]

  create_namespace = true
  atomic           = true
}

# resource "vault_mount" "apps" {
#   path        = "apps"
#   type        = "kv-v2"
#   description = "KV2 Secrets Engine for Apps."
#
#   depends_on = [
#     helm_release.vault
#   ]
# }
#
# resource "vault_generic_secret" "example" {
#   path = "apps/foo"
#
#   data_json = <<EOT
# {
#   "foo":   "bar",
#   "pizza": "cheese"
# }
# EOT
#
#   depends_on = [
#     helm_release.vault
#   ]
# }
