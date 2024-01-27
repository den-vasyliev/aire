variable "git_url" {
  description = "The URL of the Git repository where your Kubernetes manifests are."
  type        = string
}

variable "git_branch" {
  description = "The branch of the Git repository to sync with the cluster."
  type        = string
  default     = "main"
}

variable "git_path" {
  description = "The path within the Git repository to sync with the cluster."
  type        = string
  default     = "./"
}

variable "cluster_name" {
  description = "The name of the KinD Kubernetes cluster."
  type        = string
  default     = "kind-cluster"
}
