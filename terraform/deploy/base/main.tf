module "base" {
  source = "github.com/martibosch/doge-test//terraform/modules/base"

  ssh_key_name           = var.ssh_key_name
  droplet_user           = var.droplet_user
  docker_compose_version = var.docker_compose_version
  do_project_name        = var.do_project_name
  gh_repo_name           = var.gh_repo_name
  gh_username            = var.gh_username
  tf_api_token           = var.tf_api_token
}
