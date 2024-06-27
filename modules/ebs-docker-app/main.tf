resource "aws_elastic_beanstalk_application" "ebs_example_api" {
  name        = var.name
  description = var.description
}

resource "aws_iam_role" "ebs_example_api" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_role_policy_attachment" "ecr_readonly" {
  policy_arn = data.aws_iam_policy.ecr_readonly.arn
  role       = aws_iam_role.ebs_example_api.name
}

# https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2_instance-profiles.html
resource "aws_iam_instance_profile" "api" {
  name = var.name
  role = aws_iam_role.ebs_example_api.name
}
