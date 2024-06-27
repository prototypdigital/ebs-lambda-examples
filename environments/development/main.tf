module "api_docker_repository" {
  source = "../../modules/ecr"

  name = "${local.environment}-api"
}

module "beanstalk_app" {
  source = "../../modules/ebs-docker-app"

  name        = "${local.environment}-api"
  description = "${title(local.environment)} API service"
}

module "api" {
  source = "../../modules/ebs-docker-environment"

  project_name = "Test beanstalk"
  description  = "${title(local.environment)} API"

  environment = local.environment
  api_port    = 80

  instance_types         = ["t3.micro"]
  application_name       = "Test"
  vpc_id                 = data.terraform_remote_state.shared.outputs.vpc.vpc_id
  subnets                = data.terraform_remote_state.shared.outputs.vpc.public_subnets
  instance_profile_name  = module.beanstalk_app.iam_instance_profile.name
  repository_url         = module.api_docker_repository.repository_url
  allowed_address_groups = ["0.0.0.0/0"]


  db_host     = module.rds.rds_address
  db_port     = module.rds.rds_port
  db_name     = module.rds.rds_username
  db_user     = module.rds.rds_username
  db_password = module.rds.rds_password
}
