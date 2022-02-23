resource "k8s_manifest" "letsencrypt_http01_solver" {
  count   = var.solvers.http01 != null ? 1 : 0
  content = yamlencode(local.letsencrypt_http01_solver)
}

#output "default_issuer" {
#  value = var.solvers.http01.default_issuer ? "${var.name}-http01" : null
#  # var.foocrypt.default_issuer ?  var.foocrypt.name : ""
#}

locals {
  type = object({
    solvers = object({
      var.name : var.solvers.http01.default_issuer
    })
  })
}

locals {
  letsencrypt_http01_solver = {
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"
    metadata = {
      name = "${var.name}-http01"
      labels = {
        name = var.name
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
            http01 = {
              ingress = {
                # The ternary used here will set class to `var.solvers.http01.ingress_class` if `var.solvers.http01` is not null.
                class = var.solvers.http01 != null ? var.solvers.http01.ingress_class : null
              }
            }
          }
        ]
      }
    }
  }
}
