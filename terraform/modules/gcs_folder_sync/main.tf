resource "google_storage_bucket" "bucket" {
  name     = var.bucket
  location = "EU"
}

resource "google_storage_bucket_object" "map" {
  for_each = fileset("${path.root}/${var.gcs_local_source_path}", "**")
  name   = "${var.gcs_bucket_file_path}${each.value}"
  source = "${path.root}/${var.gcs_local_source_path}/${each.value}"
  bucket = var.bucket
  depends_on = [google_storage_bucket.bucket]
}
