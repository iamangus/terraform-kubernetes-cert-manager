output "default_issuer" {
  depends_on = [
    module.letsencrypt,
  ]
  value = module.letsencrypt.default_issuer
}