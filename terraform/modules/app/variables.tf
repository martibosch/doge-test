variable "env" {
  type = string
}

# variable "do_token" {}

# variable "gh_token" {}

variable "do_project_name" {}

variable "droplet_image" {
  description = "Image slug for the desired image."
  type        = string
  default     = "ubuntu-20-04-x64"
}

variable "droplet_region" {
  description = "This is the cloud hosting region where your webapp will be deployed."
  type        = string
  default     = "fra1"
}

variable "droplet_size" {
  description = "Size for the droplet."
  type        = string
  default     = "s-2vcpu-4gb"
}

variable "droplet_user" {}

variable "do_ssh_key_id" {}

variable "droplet_user_data" {}

variable "do_project_id" {}

variable "gh_repo_name" {}

# variable "ssh_private_key_pem" {}
