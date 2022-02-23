resource "kubernetes_manifest" "validating_webhook_configuration" {
  manifest = {
    "apiVersion" = "admissionregistration.k8s.io/v1"
    "kind"       = "ValidatingWebhookConfiguration"
    "metadata" = {
      "name" = var.name
      "labels" = {
        "app"                          = local.app
        "app.kubernetes.io/name"       = var.name
        "app.kubernetes.io/instance"   = var.instance_id
        "app.kubernetes.io/managed-by" = "terraform"
      }
      "annotations" = {
        "cert-manager.io/inject-ca-from-secret" = "cert-manager/cert-manager-webhook-ca"
      }
    }
    "webhooks" = [
      {
        name = "webhook.cert-manager.io"
        namespaceSelector = {
          "matchExpressions" = [
            {
              values = [
                "true"
              ]
              operator = "NotIn"
              key      = "cert-manager.io/disable-validation"
            },
            {
              values = [
                "cert-manager"
              ]
              operator = "NotIn"
              key      = "name"
            }
          ]
        }
        rules = [
          {
            apiGroups   = ["cert-manager.io", "acme.cert-manager.io"]
            apiVersions = ["v1alpha2"]
            operations  = ["CREATE", "UPDATE"]
            resources   = ["*/*"]
          }
        ]
        admissionReviewVersions = [
          "v1",
          "v1beta1"
        ]
        failurePolicy = "Fail"
        sideEffects   = "None"
        clientConfig = {
          service = {
            name      = var.name
            namespace = var.namespace
            path      = "/mutate"
          }
        }
      }
    ]
  }
}
