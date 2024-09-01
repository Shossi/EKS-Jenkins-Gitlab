resource "helm_release" "argocd" {
  depends_on = var.depends
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "4.5.2"
  namespace = "argocd"
  create_namespace = true
  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }
  set {
    name  = "server.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
    value = "nlb"
  }
}

resource "kubernetes_manifest" "argo_app" {
  manifest = yamldecode(file("../../application/app.yaml"))
}