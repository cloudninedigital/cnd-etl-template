## Airbyte OSS (abctl, Airbyte >= 2.3) on a private Compute Engine VM -> BigQuery.
## For non-Google marketing sources (Meta, LinkedIn, Microsoft Ads, ...).
## Google Ads / GA4: use BigQuery Data Transfer Service / native GA4 export instead.
##
## !! Do NOT copy this into terraform/main.tf. One VM serves all stages:
##    copy it to terraform/shared/airbyte.tf and deploy with `sh deploy.sh`.
##
## Before/after apply, read the module README (one-time OAuth setup for the web UI,
## login, BigQuery destination):
## https://github.com/cloudninedigital/cnd-terraform/tree/main/airbyte_vm
module "airbyte_vm" {
  # Pin to a cnd-terraform release tag for client projects, e.g. ?ref=v0.1.17
  source  = "github.com/cloudninedigital/cnd-terraform//airbyte_vm"
  project = var.project
  region  = var.region
  zone    = var.zone
  name    = "airbyte"

  machine_type = "e2-standard-4"
  disk_size_gb = 100

  bq_dataset_id = "airbyte_raw"
  bq_location   = "EU"

  # Pin after the first successful install (`sudo abctl version`).
  abctl_version         = ""
  airbyte_chart_version = ""

  # Deployer needs Editor + Project IAM Admin + IAP Policy Admin.
  # With only Editor: manage_iam = false, then run `terraform output -raw airbyte_manual_iam_commands`.
  manage_iam = true
  # SA-level grant needs iam.serviceAccounts.setIamPolicy (not in Project IAM Admin).
  # Not needed when SSH users are Editors.
  grant_sa_user = false

  # Who may reach Airbyte (IAP tunnel/SSH and the web UI's Google login).
  # Also add them as test users on the OAuth consent screen (see README).
  iap_members = [
    # "user:you@cloudninedigital.nl",
    # "user:contact@client.com",
  ]

  # Browser URL on Cloud Run (run.app) behind IAP. Needs the one-time OAuth setup.
  enable_web_ui = true

  enable_snapshots        = true
  snapshot_retention_days = 7

  labels = { client = "<client>" }
}

output "airbyte_web_ui_url" {
  value = module.airbyte_vm.web_ui_url
}

output "airbyte_iap_tunnel_command" {
  value = module.airbyte_vm.iap_tunnel_command
}

output "airbyte_ssh_command" {
  value = module.airbyte_vm.ssh_command
}

output "airbyte_bootstrap_log_command" {
  value = module.airbyte_vm.bootstrap_log_command
}

output "airbyte_service_account" {
  value = module.airbyte_vm.service_account_email
}

output "airbyte_manual_iam_commands" {
  value = module.airbyte_vm.manual_iam_commands
}
