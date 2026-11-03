variable "project" {
  description = "Project ID"
  type        = string
}

variable "region" {
  description = "Region of most of the resources"
  type        = string
  default     = "europe-west4"
}

variable "zone" {
  description = "Zone of most of the resources"
  default     = "europe-west4-c"
}
