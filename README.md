<!-- BEGIN_TF_DOCS -->
# HCP Terraform Policies

Code which manages configuration and life-cycle of all the HCP Terraform
Policies. It is designed to be used from a dedicated API-Driven HCP Terraform
workspace that would provision and manage the policies using Terraform code (IaC).

## Permissions

To manage resources, provide a user token from an account with appropriate
permissions. This user should have the `Manage policies` permission.
Alternatively, you can use a token from a team instead of a user token.

## Authentication

The HCP Terraform provider requires a HCP Terraform/Terraform Enterprise API token in
order to manage resources.

There are several ways to provide the required token:

- Set the `token` argument in the provider configuration. You can set the token argument in the provider configuration. Use an
input variable for the token.
- Set the `TFE_TOKEN` environment variable. The provider can read the TFE\_TOKEN environment variable and the token stored there
to authenticate.

## Features

- Manages configuration and life-cycle of HCP Terraform resources:
  - policies
  - policy sets

## Policy Set Scoping

The AWS compliance policy sets (CIS, FSBP, PCI DSS and NIST) are not global. Each one
is assigned only to workspaces that carry **all** of its required key-value tags, for
example `csp = aws` and `compliance = cis`.

> **Note:** Tag keys and values are case sensitive and must be lowercase. They must also
> already exist on at least one workspace in the organization before this code is applied,
> otherwise HCP Terraform rejects the tag inclusion with the error
> `No workspace tag found with key "..." and value "..." in this organization`.

## Test Folder Structure

Sentinel is opinionated about the folder structure required for tests. This
opinionated structure allows testing to be as simple as running sentinel
test with no arguments. Additionally, it becomes simple to test in a CI or
add new policies.

The structure Sentinel expects is `test/<policy>/*.[hcl|json]` where `<policy>`
is the name of your policy file without the file extension. Within that
folder is a list of HCL or JSON files. Each file represents a single test
case. Therefore, each policy can have multiple tests associated with it.

## Documentation

## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.13.0)

- <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) (~>0.82)

## Modules

The following Modules are called:

### <a name="module_description"></a> [description](#module\_description)

Source: ./modules/get_description

Version:

## Required Inputs

The following input variables are required:

### <a name="input_organization_name"></a> [organization\_name](#input\_organization\_name)

Description: The name of the HCP Terraform organization.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_aws_cis_git_repository_identifier"></a> [aws\_cis\_git\_repository\_identifier](#input\_aws\_cis\_git\_repository\_identifier)

Description: The VCS repository identifier for the CIS Policy Set. `oauth_client_name` must also be set.

Type: `string`

Default: `"benoitblais-hashicorp-demo/HCPTerraform-CIS-Policy-Set-for-AWS-Terraform"`

### <a name="input_aws_fsbp_git_repository_identifier"></a> [aws\_fsbp\_git\_repository\_identifier](#input\_aws\_fsbp\_git\_repository\_identifier)

Description: The VCS repository identifier for the FSBP Policy Set. `oauth_client_name` must also be set.

Type: `string`

Default: `"benoitblais-hashicorp-demo/HCPTerraform-FSBP-Policy-Set-for-AWS-Terraform"`

### <a name="input_aws_nist_git_repository_identifier"></a> [aws\_nist\_git\_repository\_identifier](#input\_aws\_nist\_git\_repository\_identifier)

Description: The VCS repository identifier for the NIST Policy Set. `oauth_client_name` must also be set.

Type: `string`

Default: `"benoitblais-hashicorp-demo/HCPTerraform-NIST-Policy-Set-for-AWS-Terraform"`

### <a name="input_aws_pcidss_git_repository_identifier"></a> [aws\_pcidss\_git\_repository\_identifier](#input\_aws\_pcidss\_git\_repository\_identifier)

Description: The VCS repository identifier for the PCI DSS Policy Set. `oauth_client_name` must also be set.

Type: `string`

Default: `"benoitblais-hashicorp-demo/HCPTerraform-PCIDSS-Policy-Set-for-AWS-Terraform"`

### <a name="input_oauth_client_name"></a> [oauth\_client\_name](#input\_oauth\_client\_name)

Description: (Optional) Name of the OAuth client.

Type: `string`

Default: `"GitHub"`

### <a name="input_policies_folder"></a> [policies\_folder](#input\_policies\_folder)

Description: The name of the folder where policies are located.

Type: `string`

Default: `"./policies"`

## Resources

The following resources are used by this module:

- [tfe_policy.this](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/policy) (resource)
- [tfe_policy_set.cis_aws](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/policy_set) (resource)
- [tfe_policy_set.fsbp_aws](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/policy_set) (resource)
- [tfe_policy_set.global](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/policy_set) (resource)
- [tfe_policy_set.nist_aws](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/policy_set) (resource)
- [tfe_policy_set.pcidss_aws](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/policy_set) (resource)
- [tfe_tag_policy_set.cis_aws](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/tag_policy_set) (resource)
- [tfe_tag_policy_set.fsbp_aws](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/tag_policy_set) (resource)
- [tfe_tag_policy_set.nist_aws](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/tag_policy_set) (resource)
- [tfe_tag_policy_set.pcidss_aws](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/tag_policy_set) (resource)
- [tfe_oauth_client.client](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/oauth_client) (data source)

## Outputs

No outputs.

<!-- markdownlint-enable -->
<!-- END_TF_DOCS -->