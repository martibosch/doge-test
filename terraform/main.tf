module "base" {
  source = "./modules/base"

  do_token = var.do_token
  # gh_token               = var.gh_token
  ssh_key_name           = var.ssh_key_name
  droplet_user           = var.droplet_user
  docker_compose_version = var.docker_compose_version
  do_project_name        = var.do_project_name
  gh_repo_name           = var.gh_repo_name
  gh_username            = var.gh_username
}

module "infrastructure" {
  source = "./modules/env"
  env    = var.env

  # do_token        = var.do_token
  # gh_token        = var.gh_token
  do_project_name = var.do_project_name
  # droplet_image      = var.droplet_image
  # droplet_region     = var.droplet_region
  # droplet_size       = var.droplet_size
  # do_ssh_key_id     = data.tfe_outputs.base.values.do_ssh_key_id
  # droplet_user_data = data.tfe_outputs.base.values.droplet_user_data
  # do_project_id     = data.tfe_outputs.base.values.do_project_id
  # gh_repo_name      = data.tfe_outputs.base.values.gh_repo_name
  do_ssh_key_id     = module.base.do_ssh_key_id
  droplet_user_data = module.base.droplet_user_data
  do_project_id     = module.base.do_project_id
  gh_repo_name      = module.base.gh_repo_name
}
