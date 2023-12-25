resource "vault_mount" "apps" {
  path        = "apps"
  type        = "kv-v2"
  description = "KV2 Secrets Engine for Apps."
}

resource "vault_kv_secret_v2" "example" {
  mount               = vault_mount.apps.path
  name                = "secret"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      zip = "zap",
      foo = "bar"
    }
  )
}
