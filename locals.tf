locals {
  helm_charts = {
    "external-secrets" = {
      repository = "https://charts.external-secrets.io"
      version    = "0.9.5"
      values     = []
    }
  }
}
