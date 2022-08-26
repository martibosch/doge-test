output "do_ssh_key_id" {
  description = "ID of the created DigitalOcean SSH key."
  value       = digitalocean_ssh_key.ssh_key.id
}

output "droplet_user_data" {
  value = data.template_file.cloud-init-yaml.rendered
}

output "do_project_id" {
  description = "ID of the created DigitalOcean project."
  value       = digitalocean_project.do_project.id
}

output "gh_repo_name" {
  description = "Name of the created GitHub repository."
  value       = data.github_repository.repo.name
}

output "ssh_key" {
  value = tls_private_key.ssh_key
}
