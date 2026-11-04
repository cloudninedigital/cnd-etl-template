terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      # >= 7.46 needed by airbyte_vm's web UI (iap_enabled on Cloud Run).
      # Independent from the dev/stg/prd root in terraform/, which has its own pin.
      version = "7.46.2"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
  zone    = var.zone
}
