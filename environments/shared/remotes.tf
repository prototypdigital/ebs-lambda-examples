terraform {
  backend "remote" {
    organization = "prototyp-dev"

    workspaces {
      name = "workshop-shared"
    }
  }
}
