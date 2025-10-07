variable "organization_name" {
  description = "The name of the HCP Terraform organization."
  type        = string

}

variable "policies_folder" {
  description = "The name of the folder where policies are located."
  type        = string
  default     = "./policies"
}