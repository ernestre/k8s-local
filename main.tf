module "kind" {
  source = "./modules/kind"
}

module "vault" {
  source = "./modules/vault"
}

module "vault-data" {
  source = "./modules/vault-data"
}

resource "helm_release" "charts" {
  for_each = local.helm_charts

  name       = each.key
  chart      = each.key
  repository = each.value.repository
  version    = each.value.version
  namespace  = each.key

  values = each.value.values

  create_namespace = true
  atomic           = true

  depends_on = [
    module.kind
  ]
}

