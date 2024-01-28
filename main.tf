terraform {
  required_version = ">= 0.12"

  required_providers {
    flux = {
      source  = "fluxcd/flux"
      version = "0.0.13"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 1.11.1"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "flux" {}

module "flux" {
  source = "fluxcd/flux2/k8s"
  target_path = "./clusters/my-cluster"
  namespace   = "flux-system"
  create_namespace = true
}
