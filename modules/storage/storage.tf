resource "google_storage_bucket" "storage-bucket" {
  name          = var.bucket_name
  location      = "US"
  force_destroy = true
}