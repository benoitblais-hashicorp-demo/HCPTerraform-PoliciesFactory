# HCP Terraform Policies

Code which manages configuration and life-cycle of all the HCP Terraform
Policies. It is designed to be used from a dedicated API-Driven HCP Terraform
workspace that would provision and manage the policies using Terraform code (IaC).

## Permissions

To manage the agent pool resources, provide a user token from an account with 
appropriate permissions. This user should have the `Manage policies` permission. 
Alternatively, you can use a token from a team instead of a user token.

## Authentication

The HCP Terraform provider requires a HCP Terraform/Terraform Enterprise API token in 
order to manage resources.

There are several ways to provide the required token:

- Set the `token` argument in the provider configuration. You can set the token argument in the provider configuration. Use an
input variable for the token.
- Set the `TFE_TOKEN` environment variable. The provider can read the TFE_TOKEN environment variable and the token stored there
to authenticate.

## Features

* Manages configuration and life-cycle of HCP Terraform resources:
  * policies
  * policy sets

## Test Folder Structure

Sentinel is opinionated about the folder structure required for tests. This
opinionated structure allows testing to be as simple as running sentinel
test with no arguments. Additionally, it becomes simple to test in a CI or
add new policies.

The structure Sentinel expects is test/<policy>/*.[hcl|json] where <policy>
is the name of your policy file without the file extension. Within that
folder is a list of HCL or JSON files. Each file represents a single test
case. Therefore, each policy can have multiple tests associated with it.
Sentinel 
