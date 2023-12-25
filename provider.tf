terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "3.7.0"
    }
  }
}

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
  address = module.vault.vault_ui_url
  token   = "root"

  # https://github.com/hashicorp/terraform-provider-vault/issues/829#issuecomment-1235321775
  skip_child_token = true
}
