resource "kubernetes_secret" "letsencrypt_dns01_cloudflare_solver_secret" {
  count = var.solvers.dns01.cloudflare != null ? 1 : 0
  metadata {
    name      = var.name
    namespace = var.namespace
  }
  data = {
    # We decode it before injecting it because the provider will re-encode it.
    "api-token" = base64decode(var.solvers.dns01.cloudflare.base64_api_key)
  }
}

resource "kubernetes_manifest" "letsencrypt_dns01_cloudflare_solver" {
  count   = length(kubernetes_secret.letsencrypt_dns01_cloudflare_solver_secret)
  manifest = yamlencode(local.letsencrypt_dns01_cloudflare_solver)
}

#output "default_issuer" {
#  value = var.solvers.dns01.cloudflare.default_issuer ? "${var.name}-dns01-cloudflare" : null
#  # var.foocrypt.default_issuer ?  var.foocrypt.name : ""
#}

#locals {
#  type = object({
#    solvers = object({
#      var.name : var.solvers.dns01.cloudflare.default_issuer
#    })
#  })
#}
     
locals {
  letsencrypt_dns01_cloudflare_solver = {
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"
    metadata = {
      name = "${var.name}-dns01-cloudflare"
      labels = {
        name = "${var.name}-dns01-cloudflare"
      }
    }
    spec = {
      acme = {
        server = var.server
        email  = var.email
        privateKeySecretRef = {
          name = kubernetes_secret.letsencrypt_issuer_secret.metadata.0.name
        }
        solvers = [
          {
            dns01 = {
              cloudflare = {
                email = var.solvers.dns01.cloudflare != null ? var.solvers.dns01.cloudflare.email : null
                apiTokenSecretRef = {
                  name = kubernetes_secret.letsencrypt_dns01_cloudflare_solver_secret.0.metadata.0.name
                }
              }
            }
          }
        ]
      }
    }
  }
}
