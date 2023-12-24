locals {
  helm_charts = {
    "external-secrets" = {
      repository = "https://charts.external-secrets.io"
      version    = "0.9.5"
      values     = []
    }

    "vault" = {
      repository = "https://helm.releases.hashicorp.com"
      version    = "0.25.0"
      values = [
        "${file("./charts/vault/values.yaml")}"
      ]
    }
  }
}
