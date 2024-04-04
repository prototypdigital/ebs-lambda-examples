module "terraform_user" {
  source               = "../../modules/iam-user"
  name                 = "terraform"
  allow_console_access = false
}

module "vlatko_vlahek_user" {
  source               = "../../modules/iam-user"
  name                 = "vlatko.vlahek"
  allow_console_access = true
}

module "josip_ravas_user" {
  source               = "../../modules/iam-user"
  name                 = "josip.ravas"
  allow_console_access = true
}

