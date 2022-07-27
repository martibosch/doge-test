terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    github = {
      source  = "integrations/github"
      version = "~> 4.0"
    }
    sshclient = {
      source  = "luma-planet/sshclient"
      version = "~> 1.0"
    }
  }
}
