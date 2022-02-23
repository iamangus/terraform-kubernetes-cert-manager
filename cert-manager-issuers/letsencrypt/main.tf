resource "kubernetes_secret" "letsencrypt_issuer_secret" {
  metadata {
    name      = var.name
    namespace = var.namespace
  }
  data = {
    # We decode it before injecting it because the provider will re-encode it.
    "tls.key" = base64decode(var.secret_base64_key)
  }
}