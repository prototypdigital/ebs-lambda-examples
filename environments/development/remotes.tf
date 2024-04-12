terraform {
  backend "remote" {
    organization = "prototyp-dev"

    workspaces {
      name = "workshop-development"
    }
  }
}
