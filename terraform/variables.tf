variable "env" {}

variable "do_token" {}

# variable "gh_token" {}

variable "do_project_name" {}

variable "ssh_key_name" {}

variable "droplet_user" {}

variable "docker_compose_version" {
  description = "Version of docker-compose."
  type        = string
  default     = "2.6.1"
}

variable "gh_repo_name" {}

variable "gh_username" {}

# variable "droplet_image" {
# }

# variable "droplet_region" {
# }

# variable "droplet_size" {
# }
