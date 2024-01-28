provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "kind-kind"
}

resource "kubernetes_namespace" "flux_system" {
  metadata {
    name = "flux-system"
  }
}

resource "helm_release" "fluxcd" {
  name       = "fluxcd"
  repository = "https://charts.fluxcd.io"
  chart      = "flux"
  namespace  = kubernetes_namespace.flux_system.metadata[0].name

  set {
    name  = "git.url"
    value = "https://github.com/your-org/your-repo"
  }

  set {
    name  = "git.branch"
    value = "main"
  }

  set {
    name  = "git.path"
    value = "clusters/my-cluster"
  }

  set {
    name  = "sync.interval"
    value = "1m"
  }
}

resource "helm_release" "helm_operator" {
  name       = "helm-operator"
  repository = "https://charts.fluxcd.io"
  chart      = "helm-operator"
  namespace  = kubernetes_namespace.flux_system.metadata[0].name

  set {
    name  = "git.ssh.secretName"
    value = "flux-git-deploy"
  }

  set {
    name  = "helm.versions"
    value = "v3"
  }
}