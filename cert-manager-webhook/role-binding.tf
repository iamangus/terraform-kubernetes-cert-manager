resource "kubernetes_role_binding" "role_binding" {
  metadata {
    name      = "${var.name}:webhook-authentication-reader"
    namespace = "kube-system"
    labels = merge({
      "app.kubernetes.io/name" = var.name
    }, local.labels)
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind = "Role"
    name = "extension-apiserver-authentication-reader"
  }
  subject {
    api_group = ""
    kind = "ServiceAccount"
    name = kubernetes_service_account.service_account.metadata.0.name
    namespace = kubernetes_service_account.service_account.metadata.0.namespace
  }
}