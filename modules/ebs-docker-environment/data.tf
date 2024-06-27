data "aws_elastic_beanstalk_solution_stack" "docker" {
  most_recent = true
  name_regex  = "^(.*)Docker$"
}

# data "aws_iam_role" "api" {
#   name = var.instance_profile_name
# }

data "aws_iam_policy" "cognito_power_user" {
  name = "AmazonCognitoPowerUser"
}

data "archive_file" "config" {
  type        = "zip"
  output_path = "${path.module}/${var.environment}.zip"

  source {
    filename = ".platform/nginx/conf.d/elasticbeanstalk/locations.conf"
    content  = file("${path.module}/config/locations.conf")
  }

  source {
    filename = ".platform/nginx/nginx.conf"
    content  = file("${path.module}/config/nginx.conf")
  }

  source {
    filename = ".platform/nginx/.htpasswd"
    content  = "${local.basic_auth_username}:{SHA}${local.basic_auth_password}"
  }

  source {
    filename = "Dockerrun.aws.json"
    content = templatefile("${path.module}/config/Dockerrun.aws.json", {
      repository_url = var.repository_url
      environment    = var.environment
      api_port       = var.api_port
    })
  }
}

