## Secrets
resource "github_repository_environment" "env" {
  repository  = var.gh_repo_name # github_repository.repository.name
  environment = var.env
}

resource "github_actions_environment_secret" "known_hosts" {
  repository  = var.gh_repo_name # github_repository.repository.name
  environment = github_repository_environment.env.environment
  secret_name = "known_hosts"
  plaintext_value = templatefile(
    "${path.module}/templates/known_hosts.tpl",
    {
      keyscan = [data.sshclient_keyscan.keyscan],
    }
  )
}
