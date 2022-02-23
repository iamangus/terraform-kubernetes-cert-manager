# This will be a decision tree. I should probably chop it down before it grows too large...
#output "default_issuer" {
#  value = var.letsencrypt.default_issuer ? var.letsencrypt.name : ""
#  # var.foocrypt.default_issuer ?  var.foocrypt.name : ""
#}

module "letsencrypt_issuer" {
  source = "./letsencrypt"

  count = var.letsencrypt == null ? 0 : 1

  namespace         = var.namespace
  name              = var.letsencrypt.name
  server            = var.letsencrypt.server
  email             = var.letsencrypt.email
  secret_base64_key = var.letsencrypt.secret_base64_key
  solvers           = var.letsencrypt.solvers
}