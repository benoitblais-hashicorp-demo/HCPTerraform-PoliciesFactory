# The following code block is used to create Terraform Cloud Policies.

locals {
  # This local is used to get a list of all folder inside the policies folder.
  files = fileset(var.policies_folder, "*/*.sentinel")
}

module "description" {
  for_each = local.files
  source   = "./modules/get_description"
  path     = "${var.policies_folder}/${each.key}"
}

resource "tfe_policy" "this" {
  for_each     = local.files
  name         = element(split(".", element(split("/", each.key), 1)), 2)
  description  = module.description[each.value].description
  organization = var.organization_name
  kind         = "sentinel"
  policy       = file("${var.policies_folder}/${each.key}")
  enforce_mode = "hard-mandatory" # advisory, hard-mandatory and soft-mandatory
}

# The following code block is used to create Terraform Cloud Policy Sets.

resource "tfe_policy_set" "global" {
  name         = "Global-Policy-Set"
  description  = "This policy-set is assigned at the organization level."
  organization = var.organization_name
  global       = true
  kind         = "sentinel"
  policy_ids   = [for value in tfe_policy.this : value.id]
}

# The following block is use to get information about an OAuth client.

data "tfe_oauth_client" "client" {
  count        = var.oauth_client_name != null ? 1 : 0
  organization = var.organization_name
  name         = var.oauth_client_name
}

# The following block is used to create a Policy Set from a VCS repository for AWS CIS.
# It is applied only to workspaces that have ALL of the tags defined in `local.cis_aws_tags`.

locals {
  cis_aws_tags = {
    csp        = "aws"
    compliance = "cis"
  }
}

resource "tfe_policy_set" "cis_aws" {
  count           = var.aws_cis_git_repository_identifier != null ? 1 : 0
  name            = "AWS-CIS-Policy-Set"
  description     = "CIS Benchmark for AWS policy-set, assigned to workspaces tagged with csp = aws and compliance = cis."
  organization    = var.organization_name
  kind            = "sentinel"
  tag_match_logic = "all"
  vcs_repo {
    identifier         = var.aws_cis_git_repository_identifier
    branch             = "main"
    ingress_submodules = false
    oauth_token_id     = data.tfe_oauth_client.client[0].oauth_token_id
  }
  lifecycle {
    precondition {
      condition     = var.oauth_client_name != null ? true : false
      error_message = "`oauth_client_name` must be set when `aws_cis_git_repository_identifier` is set."
    }
  }
}

resource "tfe_tag_policy_set" "cis_aws" {
  for_each      = var.aws_cis_git_repository_identifier != null ? local.cis_aws_tags : {}
  policy_set_id = tfe_policy_set.cis_aws[0].id
  key           = each.key
  value         = each.value
}

# The following block is used to create a Policy Set from a VCS repository for AWS FSBP.
# It is applied only to workspaces that have ALL of the tags defined in `local.fsbp_aws_tags`.

locals {
  fsbp_aws_tags = {
    csp        = "aws"
    compliance = "fsbp"
  }
}

resource "tfe_policy_set" "fsbp_aws" {
  count           = var.aws_fsbp_git_repository_identifier != null ? 1 : 0
  name            = "AWS-FSBP-Policy-Set"
  description     = "AWS Foundational Security Best Practices policy-set, assigned to workspaces tagged with csp = aws and compliance = fsbp."
  organization    = var.organization_name
  kind            = "sentinel"
  tag_match_logic = "all"
  vcs_repo {
    identifier         = var.aws_fsbp_git_repository_identifier
    branch             = "main"
    ingress_submodules = false
    oauth_token_id     = data.tfe_oauth_client.client[0].oauth_token_id
  }
  lifecycle {
    precondition {
      condition     = var.oauth_client_name != null ? true : false
      error_message = "`oauth_client_name` must be set when `aws_fsbp_git_repository_identifier` is set."
    }
  }
}

resource "tfe_tag_policy_set" "fsbp_aws" {
  for_each      = var.aws_fsbp_git_repository_identifier != null ? local.fsbp_aws_tags : {}
  policy_set_id = tfe_policy_set.fsbp_aws[0].id
  key           = each.key
  value         = each.value
}

# The following block is used to create a Policy Set from a VCS repository for AWS PCI DSS.
# It is applied only to workspaces that have ALL of the tags defined in `local.pcidss_aws_tags`.

locals {
  pcidss_aws_tags = {
    csp        = "aws"
    compliance = "pcidss"
  }
}

resource "tfe_policy_set" "pcidss_aws" {
  count           = var.aws_pcidss_git_repository_identifier != null ? 1 : 0
  name            = "AWS-PCIDSS-Policy-Set"
  description     = "PCI DSS for AWS policy-set, assigned to workspaces tagged with csp = aws and compliance = pcidss."
  organization    = var.organization_name
  kind            = "sentinel"
  tag_match_logic = "all"
  vcs_repo {
    identifier         = var.aws_pcidss_git_repository_identifier
    branch             = "main"
    ingress_submodules = false
    oauth_token_id     = data.tfe_oauth_client.client[0].oauth_token_id
  }
  lifecycle {
    precondition {
      condition     = var.oauth_client_name != null ? true : false
      error_message = "`oauth_client_name` must be set when `aws_pcidss_git_repository_identifier` is set."
    }
  }
}

resource "tfe_tag_policy_set" "pcidss_aws" {
  for_each      = var.aws_pcidss_git_repository_identifier != null ? local.pcidss_aws_tags : {}
  policy_set_id = tfe_policy_set.pcidss_aws[0].id
  key           = each.key
  value         = each.value
}

# The following block is used to create a Policy Set from a VCS repository for AWS NIST.
# It is applied only to workspaces that have ALL of the tags defined in `local.nist_aws_tags`.

locals {
  nist_aws_tags = {
    csp        = "aws"
    compliance = "nist"
  }
}

resource "tfe_policy_set" "nist_aws" {
  count           = var.aws_nist_git_repository_identifier != null ? 1 : 0
  name            = "AWS-NIST-Policy-Set"
  description     = "NIST for AWS policy-set, assigned to workspaces tagged with csp = aws and compliance = nist."
  organization    = var.organization_name
  kind            = "sentinel"
  tag_match_logic = "all"
  vcs_repo {
    identifier         = var.aws_nist_git_repository_identifier
    branch             = "main"
    ingress_submodules = false
    oauth_token_id     = data.tfe_oauth_client.client[0].oauth_token_id
  }
  lifecycle {
    precondition {
      condition     = var.oauth_client_name != null ? true : false
      error_message = "`oauth_client_name` must be set when `aws_nist_git_repository_identifier` is set."
    }
  }
}

resource "tfe_tag_policy_set" "nist_aws" {
  for_each      = var.aws_nist_git_repository_identifier != null ? local.nist_aws_tags : {}
  policy_set_id = tfe_policy_set.nist_aws[0].id
  key           = each.key
  value         = each.value
}