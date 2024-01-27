output "flux_git_deploy_key" {
  description = "The deploy key that needs to be added to your Git repository."
  value       = module.flux.git_deploy_key
}
