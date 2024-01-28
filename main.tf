terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "~> 0.0.19"
    }
    fluxcd = {
      source  = "fluxcd/flux"
      version = "~> 2.0"
    }
  }
}
variable "GITHUB_OWNER" {
  description = "The owner of the GitHub repository."
  type        = string
  default     = ""
}
variable "FLUX_GITHUB_REPO" {
  description = "The name of the GitHub repository for Flux."
  type        = string
default     = "default-repo-name"
}

variable "GITHUB_TOKEN" {
  description = "The GitHub token for authentication."
  type        = string
  default     = ""
}

variable "GOOGLE_REGION" {
  description = "The Google Cloud region."
  type        = string
  default     = "us-central1"
}

variable "GOOGLE_PROJECT" {
  description = "The Google Cloud project ID."
  type        = string
  default     = ""
}

variable "KMS_KEYRING_NAME" {
  description = "The name of the KMS keyring."
  type        = string
  default     = ""
}
module "github_repository" {
  source                   = "github.com/den-vasyliev/tf-github-repository"
  github_owner             = var.GITHUB_OWNER
  github_token             = var.GITHUB_TOKEN
  repository_name          = var.FLUX_GITHUB_REPO
  public_key_openssh       = module.tls_private_key.public_key_openssh
  public_key_openssh_title = "flux"
}

module "gke_cluster" {
  source         = "github.com/den-vasyliev/tf-google-gke-cluster?ref=gke_auth"
  GOOGLE_REGION  = var.GOOGLE_REGION
  GOOGLE_PROJECT = var.GOOGLE_PROJECT
  GKE_NUM_NODES  = 2
}

module "flux_bootstrap" {
  source            = "github.com/den-vasyliev/tf-fluxcd-flux-bootstrap?ref=gke_auth"
  github_repository = "${var.GITHUB_OWNER}/${var.FLUX_GITHUB_REPO}"
  private_key       = module.tls_private_key.private_key_pem
  config_host       = module.gke_cluster.config_host
  config_token      = module.gke_cluster.config_token
  config_ca         = module.gke_cluster.config_ca
  github_token      = var.GITHUB_TOKEN
}

module "tls_private_key" {
  source = "github.com/den-vasyliev/tf-hashicorp-tls-keys"
}

module "gke-workload-identity" {
  source              = "terraform-google-modules/kubernetes-engine/google//modules/workload-identity"
  use_existing_k8s_sa = true
  name                = "kustomize-controller"
  namespace           = "flux-system"
  project_id          = var.GOOGLE_PROJECT
  annotate_k8s_sa     = false
  roles               = ["roles/cloudkms.cryptoKeyEncrypterDecrypter"]
}

module "kms" {
  source          = "github.com/den-vasyliev/terraform-google-kms"
  project_id      = var.GOOGLE_PROJECT
  keyring         = var.KMS_KEYRING_NAME
  location        = "global"
  keys            = ["sops-key"]
  prevent_destroy = false
}
