module "flux" {
  source = "fluxcd/flux//kubernetes" // This is the Terraform module for Flux
  version = "0.0.13" // Specify the version of the Flux module

  git_url    = var.git_url
  git_branch = var.git_branch
  git_path   = var.git_path

  set = {
    "name" = "flux"
    "namespace" = "flux"
  }

  depends_on = [kind_cluster.this]
}

resource "kind_cluster" "this" {
  name = var.cluster_name
provider = "kind"
}
