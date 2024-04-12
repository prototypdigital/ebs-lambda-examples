variable "domain_name" {
  description = "DNS Domain name for the environment"
  type        = string
}

variable "additional_domain_names" {
  description = "Additional domain names"
  type        = list(string)
  default     = []
}

variable "environment" {
  description = "Environment."
  type        = string

  validation {
    condition     = contains(["development", "production"], var.environment)
    error_message = "Allowed values for environment are development or production."
  }
}
