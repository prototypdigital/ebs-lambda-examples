module "api_user" {
  source               = "../../modules/iam-user"
  name                 = "${var.project_name}.${var.environment}.app"
  allow_console_access = false
}

module "api_group" {
  source      = "../../modules/iam-user-group"
  name        = "${var.project_name}.${var.environment}"
  policy_arns = [data.aws_iam_policy.cognito_power_user.arn]

  members = [
    module.api_user.user_name,
  ]
}

resource "aws_elastic_beanstalk_application_version" "api_v1" {
  name        = var.environment
  application = var.application_name
  bucket      = aws_s3_bucket.api.id
  key         = aws_s3_object.api_v1.key
}

resource "aws_security_group" "beanstalk" {
  name        = "${local.resource_name}-beanstalk"
  vpc_id      = var.vpc_id
  description = "Allow inbound traffic from specified destinations to lambda server"

  ingress {
    protocol    = "tcp"
    from_port   = var.api_port
    to_port     = var.api_port
    cidr_blocks = var.allowed_address_groups
  }

  tags = {
    Name        = "${local.resource_name}-beanstalk"
    Environment = var.environment
  }
}

resource "aws_elastic_beanstalk_environment" "api" {
  name                = local.resource_name
  application         = var.application_name
  solution_stack_name = data.aws_elastic_beanstalk_solution_stack.docker.name
  version_label       = aws_elastic_beanstalk_application_version.api_v1.name

  tier = "WebServer"

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", var.subnets)
  }

  setting {
    namespace = "aws:ec2:instances"
    name      = "InstanceTypes"
    value     = join(",", var.instance_types)
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = var.instance_profile_name
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "EC2KeyName"
    value     = aws_key_pair.api.key_name
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = aws_security_group.beanstalk.id
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "API_PORT"
    value     = var.api_port
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "AWS_REGION"
    value     = "eu-central-1"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "AWS_ACCESS_KEY_ID"
    value     = module.api_user.user_access_key
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "AWS_SECRET_ACCESS_KEY"
    value     = module.api_user.user_access_secret
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_HOST"
    value     = var.db_host
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_PORT"
    value     = var.db_port
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_USERNAME"
    value     = var.db_user
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_PASSWORD"
    value     = var.db_password
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DB_NAME"
    value     = var.db_name
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "AUTH_HEADER_USERNAME"
    value     = "admin"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "AUTH_HEADER_PASSWORD"
    value     = "admin"
  }
}
