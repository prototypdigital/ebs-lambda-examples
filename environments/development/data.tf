data "terraform_remote_state" "shared" {
  backend = "remote"

  config = {
    organization = "prototyp-dev"
    workspaces = {
      name = "workshop-shared"
    }
  }
}
