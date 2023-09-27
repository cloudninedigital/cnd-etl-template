resource "google_bigquery_dataset" "dataset" {
  dataset_id = var.dataset_id
  friendly_name = var.friendly_name
  description = var.description
  location = var.region

  default_table_expiration_ms = var.default_table_expiration_ms
  default_partition_expiration_ms = var.default_partition_expiration_ms
}

resource "google_bigquery_table" "tables" {
  for_each = var.tables
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = each.table_id

  time_partitioning {
    for_each = each.partition_table ? [1] : []
    type = each.partition_type
    field = each.value.partition_field
    require_partition_filter = each.require_partition_filter
  }

  schema = each.value.schema
}
