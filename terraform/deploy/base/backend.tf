terraform {
  cloud {
    organization = "exaf-epfl"
    workspaces {
      name = "doge-test-base"
    }
  }
}
