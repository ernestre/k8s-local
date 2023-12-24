resource "vault_mount" "apps" {
  path        = "apps"
  type        = "kv-v2"
  description = "KV2 Secrets Engine for Apps."
}
