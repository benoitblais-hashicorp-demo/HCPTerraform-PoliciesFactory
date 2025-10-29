variable "organization_name" {
  description = "The name of the HCP Terraform organization."
  type        = string
}

variable "aws_cis_git_repository_identifier" {
  description = "The VCS repository identifier for the CIS Policy Set. `oauth_client_name` must also be set."
  type        = string
  default     = "benoitblais-hashicorp-demo/HCPTerraform-CIS-Policy-Set-for-AWS-Terraform"
}

variable "oauth_client_name" {
  description = "(Optional) Name of the OAuth client."
  type        = string
  nullable    = false
  default     = "GitHub"
}

variable "policies_folder" {
  description = "The name of the folder where policies are located."
  type        = string
  default     = "./policies"
}
