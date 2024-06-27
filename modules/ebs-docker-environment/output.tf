output "ssh_private_key" {
  description = "Value of the private key for the elastic beanstalk instance in PEM format"
  value       = tls_private_key.api.private_key_pem
  sensitive   = true
}

output "instances" {
  description = "Instance IDs of the API deployment"
  value       = aws_elastic_beanstalk_environment.api.instances
}
