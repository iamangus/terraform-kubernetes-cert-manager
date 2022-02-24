resource "kubernetes_cluster_role" "cluster_role" {
  metadata {
    name = var.name
    labels = merge({
      "app.kubernetes.io/name" = var.name
    }, local.labels)
  }

  rule {
    api_groups = ["cert-manager.io"]
    resources = [
      "certificates"
    ]
    verbs = ["get", "list", "watch"]
  }

  rule {
    api_groups = [""]
    resources = [
      "secrets"
    ]
    verbs = ["get", "list", "watch"]
  }

  rule {
    api_groups = [""]
    resources = [
      "events"
    ]
    verbs = ["get", "create", "update", "patch"]
  }
  
  rule {
    api_groups = [""]
    resources = [
      "configmaps"
    ]
    verbs = ["get", "create", "update"]
  }

  rule {
    api_groups = ["admissionregistration.k8s.io"]
    resources = [
      "validatingwebhookconfigurations",
      "mutatingwebhookconfigurations"
    ]
    verbs = ["get", "list", "watch", "update"]
  }
  
  rule {
    api_groups = ["coordination.k8s.io"]
    resources = [
      "leases"
    ]
    verbs = ["create", "get", "update"]
  }

  rule {
    api_groups = ["apiregistration.k8s.io"]
    resources = [
      "apiservices"
    ]
    verbs = ["get", "list", "watch", "update"]
  }

  rule {
    api_groups = ["apiextensions.k8s.io"]
    resources = [
      "customresourcedefinitions"
    ]
    verbs = ["get", "list", "watch", "update"]
  }
}
