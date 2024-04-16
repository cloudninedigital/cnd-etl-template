variable "name" {
  description = "Name of workflow"
  type        = string
}

variable "description" {
  description = "Description of workflow"
  type        = string
}

variable "project" {
  description = "Project ID"
  type        = string
}

variable "dataset" {
  description = "BigQuery dataset to trigger workflow on"
  type        = string
  default     = ""
}

variable "table" {
  description = "BigQuery table (or table pattern) to trigger workflow on"
  type        = string
  default     = ""
}

variable "cloudfunctions" {
  description = "list of cloudfunction maps to execute in the flow"
  type        = list
  default     = [{name: "example_cf", table_updated: "some_dataset.iets"}]
}

variable "dataform_pipelines" {
  description = "list of dataform pipeline maps to execute in the flow"
  type        = list
  default     = [{name: "example_dp", tag: "example_tag", repository: "dataform_repo_example"}]
}

variable "workflow_type" {
  description= "type of workflow to be triggered (determines the template being used). options are 'cf' (for cloud_functions), 'dataform', 'airflow' and 'dbt'"
  type = string
  default = "cf"
}

variable trigger_type {
  description = "Type of trigger used to start workflow. Available options: http, schedule, gcs, bq"
  type = string
  default = "http"
}

variable "region" {
  description = "Region of the workflow"
  type        = string
  default     = "europe-west3"
}

variable "functions_region" {
  description = "Region where Cloud functions are deployed."
  type = string
  default     = "europe-west3"
}

variable "dataform_region" {
  description = "Region where dataform is deployed."
  type = string
  default     = "europe-west3"
}

variable "airflow_server_domain" {
  description= "server domain of airflow (without https://)"
  type=string
  default=""
}

variable "airflow_dags" {
  description= "airflow dags (if workflow type == airflow)"
  type=list
  default=[{dag_id: "exampleid"}]
}

variable "dbt_jobs" {
  description= "dbt jobs (if workflow type == dbt)"
  type=list
  default=[{job_id: "exampleid"}]
}

variable "dbt_account_id" {
  description= "dbt jobs (if workflow type == dbt)"
  type=string
  default=""
}


variable "dbt_token_secret" {
  description="dbt token secret name (to be taken from google_secret_manager)"
  type=string
  default=""
}

variable "bucket_name" {
  description = "Name of bucket that triggers the workflow"
  type        = string
  default = ""
}

variable "schedule" {
  description = "The schedule on which to trigger the function."
  type        = string
  default     = "1 1 * * *"

}

variable "service_account_name" {
  description = "Name of service account to use for workflow"
  type        = string
}

variable "alert_on_failure" {
  description = "The schedule on which to trigger the function."
  type        = bool
  default     = false
}

variable "alert_email_addresses" {
  description = "email addresses to send notifications to"
  type = map(string)
  default = {
    cnd_alerts = "alerting@cloudninedigital.nl"
  }
}
