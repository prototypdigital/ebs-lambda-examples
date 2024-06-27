module "api_docker_repository" {
  source = "../../modules/ecr"

  name = "${local.environment}-api"
}

module "beanstalk_app" {
  source = "../../modules/ebs-docker-app"

  name        = "${local.environment}-api"
  description = "${title(local.environment)} API service"
}

module "rds" {
  source      = "../../modules/rds"
  vpc_id      = data.terraform_remote_state.shared.outputs.vpc.vpc_id
  environment = local.environment

  db_server_name         = "${local.environment}-db"
  db_server_type         = "postgres"
  db_server_version      = "14.10"
  db_instance_class      = "db.t4g.micro"
  allocated_storage      = 50
  is_publicly_accessible = true
  is_multi_az            = false
  allowed_address_groups = ["0.0.0.0/0"]
  subnets                = data.terraform_remote_state.shared.outputs.vpc.public_subnets
}

module "api" {
  source = "../../modules/ebs-docker-environment"

  project_name = "cobe-test"
  description  = "${title(local.environment)} API"

  environment            = local.environment
  api_port               = 80
  allowed_address_groups = ["0.0.0.0/0"]


  instance_types        = ["t3.micro"]
  application_name      = "test"
  vpc_id                = data.terraform_remote_state.shared.outputs.vpc.vpc_id
  subnets               = data.terraform_remote_state.shared.outputs.vpc.public_subnets
  instance_profile_name = module.beanstalk_app.iam_instance_profile.name
  repository_url        = "registry.hub.docker.com/library"
  docker_image_name     = "busybox"


  db_host     = module.rds.rds_address
  db_port     = module.rds.rds_port
  db_name     = module.rds.rds_username
  db_user     = module.rds.rds_username
  db_password = module.rds.rds_password
}
