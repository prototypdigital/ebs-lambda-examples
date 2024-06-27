variable "environment" {
  description = "Environment."
  type        = string

  validation {
    condition     = contains(["development", "production"], var.environment)
    error_message = "Allowed values for environment are development or production."
  }
}

variable "project_name" {
  description = "Project Name. Serves as a baseline for resource naming"
}

variable "description" {
  type        = string
  description = "The description of the Elastic Beanstalk application"
}

variable "application_name" {
  type        = string
  description = "The name of the Elastic Beanstalk application that this environment will created for"
}

variable "instance_profile_name" {
  type        = string
  description = "The name of the IAM instance profile to use for the environment"
}

variable "repository_url" {
  type        = string
  description = "The URL of the ECR repository to use for the environment"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC to use for the environment"
}

variable "subnets" {
  type        = list(string)
  description = "The list of subnets to use for the environment"
}

variable "instance_types" {
  type        = set(string)
  description = "The instance type to use for the environment"
}

variable "api_port" {
  type        = string
  description = "The port to use for the API"
}

variable "allowed_address_groups" {
  description = "Allowed CIDR groups"
  type        = list(string)
}

variable "db_host" {
  type        = string
  description = "Database host"
}

variable "db_port" {
  type        = string
  description = "Database port"
}

variable "db_name" {
  type        = string
  description = "Database name"
}

variable "db_user" {
  type        = string
  description = "Database user"
}

variable "db_password" {
  type        = string
  description = "Database password"
  sensitive   = true
}
