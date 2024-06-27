resource "tls_private_key" "api" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "api" {
  key_name   = "${local.resource_name}-ssh"
  public_key = tls_private_key.api.public_key_openssh
}
