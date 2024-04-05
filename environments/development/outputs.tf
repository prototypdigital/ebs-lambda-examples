output "shared" {
  description = "Shared output"
  value       = data.terraform_remote_state.shared.outputs.vpc
}
