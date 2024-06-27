
output "app_info" {
  description = "Name of the Elastic Beanstalk application"
  value       = aws_elastic_beanstalk_application.ebs_example_api
}

output "iam_role" {
  description = "IAM role for the Elastic Beanstalk application"
  value       = aws_iam_role.ebs_example_api
}

output "iam_instance_profile" {
  description = "IAM instance profile for the Elastic Beanstalk application"
  value       = aws_iam_instance_profile.api
}
