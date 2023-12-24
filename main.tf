provider "helm" {
  kubernetes {
    host = module.kind.kind_cluster.server

    client_certificate     = base64decode(module.kind.kind_cluster.client_certificate_data)
    client_key             = base64decode(module.kind.kind_cluster.client_key_data)
    cluster_ca_certificate = base64decode(module.kind.kind_cluster.ca_certificate_data)
  }
}

provider "kubernetes" {
  host = module.kind.kind_cluster.server

  client_certificate     = base64decode(module.kind.kind_cluster.client_certificate_data)
  client_key             = base64decode(module.kind.kind_cluster.client_key_data)
  cluster_ca_certificate = base64decode(module.kind.kind_cluster.ca_certificate_data)
}

provider "vault" {
  address = local.vault.ui_url
  token   = "root"

  # https://github.com/hashicorp/terraform-provider-vault/issues/829#issuecomment-1235321775
  skip_child_token = true
}

module "kind" {
  source = "./modules/kind"
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

module "vault" {
  source = "./modules/vault"
}
