locals {
  vault = {
    ui_url = format("http://%s", data.kubernetes_service.service_vault_ui.status[0].load_balancer[0].ingress[0].ip)
  }
}

data "kubernetes_service" "service_vault_ui" {
  metadata {
    name      = "vault-ui"
    namespace = helm_release.charts["vault"].namespace
  }

  depends_on = [
    helm_release.charts["vault"]
  ]
}

output "vault_ui_url" {
  value       = local.vault.ui_url
  description = "vault ui url"
}
