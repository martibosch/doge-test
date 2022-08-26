# organization
data "tfe_organization" "org" {
  name = var.tfc_org_name
}

# workspaces
resource "tfe_workspace" "stage" {
  name         = "${var.project_slug}-stage"
  organization = data.tfe_organization.org.name
  tag_names    = [var.project_slug]
  # execution_mode = "local"
}

resource "tfe_workspace" "prod" {
  name         = "${var.project_slug}-prod"
  organization = data.tfe_organization.org.name
  tag_names    = [var.project_slug]
  # execution_mode = "local"
}

resource "tfe_workspace" "base" {
  name         = "${var.project_slug}-base"
  organization = data.tfe_organization.org.name
  tag_names    = [var.project_slug]
  # execution_mode            = "local"
  remote_state_consumer_ids = [tfe_workspace.stage.id, tfe_workspace.prod.id]
}

# tokens
# resource "tfe_organization_token" "token" {
#   organization = data.tfe_organization.org.name
# }

# variables
## base variable set
resource "tfe_variable_set" "base" {
  name         = "base variable set"
  description  = "variable set applied to the base workspace only"
  organization = data.tfe_organization.org.name
}

resource "tfe_variable" "ssh_key_name" {
  key             = "ssh_key_name"
  value           = var.ssh_key_name
  category        = "terraform"
  variable_set_id = tfe_variable_set.base.id
}

resource "tfe_variable" "docker_compose_version" {
  key             = "docker_compose_version"
  value           = var.docker_compose_version
  category        = "terraform"
  variable_set_id = tfe_variable_set.base.id
}

resource "tfe_variable" "gh_repo_name" {
  key             = "gh_repo_name"
  value           = var.gh_repo_name
  category        = "terraform"
  variable_set_id = tfe_variable_set.base.id
}

resource "tfe_variable" "gh_username" {
  key             = "gh_username"
  value           = var.gh_username
  category        = "terraform"
  variable_set_id = tfe_variable_set.base.id
}

resource "tfe_variable" "tf_api_token" {
  key = "tf_api_token"
  # value           = tfe_organization_token.token.token
  value           = var.tf_api_token
  category        = "terraform"
  variable_set_id = tfe_variable_set.base.id
}

resource "tfe_workspace_variable_set" "base" {
  variable_set_id = tfe_variable_set.base.id
  workspace_id    = tfe_workspace.base.id
}

## app variable set
resource "tfe_variable_set" "app" {
  name         = "app variable set"
  description  = "variable set applied to the app workspaces (stage, prod)"
  organization = data.tfe_organization.org.name
}

resource "tfe_variable" "tfc_org_name" {
  key             = "tfc_org_name"
  value           = var.tfc_org_name
  category        = "terraform"
  variable_set_id = tfe_variable_set.app.id
}

resource "tfe_variable" "tfc_base_workspace_name" {
  key             = "tfc_base_workspace_name"
  value           = tfe_workspace.base.name
  category        = "terraform"
  variable_set_id = tfe_variable_set.app.id
}

resource "tfe_workspace_variable_set" "app_stage" {
  variable_set_id = tfe_variable_set.app.id
  workspace_id    = tfe_workspace.stage.id
}

resource "tfe_workspace_variable_set" "app_prod" {
  variable_set_id = tfe_variable_set.app.id
  workspace_id    = tfe_workspace.prod.id
}

## shared variable set
resource "tfe_variable_set" "shared" {
  name         = "shared variable set"
  description  = "variable set applied to all deploy workspaces"
  organization = data.tfe_organization.org.name
}

resource "tfe_variable" "droplet_user" {
  key             = "droplet_user"
  value           = var.droplet_user
  category        = "terraform"
  variable_set_id = tfe_variable_set.shared.id
}

resource "tfe_variable" "do_project_name" {
  key             = "do_project_name"
  value           = var.do_project_name
  category        = "terraform"
  variable_set_id = tfe_variable_set.shared.id
}

resource "tfe_variable" "do_token" {
  key             = "do_token"
  value           = var.do_token
  category        = "terraform"
  variable_set_id = tfe_variable_set.shared.id
}

resource "tfe_variable" "gh_token" {
  key             = "gh_token"
  value           = var.gh_token
  category        = "terraform"
  variable_set_id = tfe_variable_set.shared.id
}

resource "tfe_workspace_variable_set" "shared_base" {
  variable_set_id = tfe_variable_set.shared.id
  workspace_id    = tfe_workspace.base.id
}

resource "tfe_workspace_variable_set" "shared_stage" {
  variable_set_id = tfe_variable_set.shared.id
  workspace_id    = tfe_workspace.stage.id
}

resource "tfe_workspace_variable_set" "shared_prod" {
  variable_set_id = tfe_variable_set.shared.id
  workspace_id    = tfe_workspace.prod.id
}
