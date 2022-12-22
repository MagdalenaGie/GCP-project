resource "google_storage_bucket" "bucket" {
  name = "nananananatestbucketforfunction"
}

resource "google_storage_bucket_object" "archive" {
  name   = "function.zip"
  bucket = "${google_storage_bucket.bucket.name}"
  source = "./src/function.zip"
}

resource "google_cloudfunctions_function" "slack_webhook_cf" {
  name                  = "slack_webhook"
  runtime               = "nodejs12"
  entry_point           = "helloPubSub"
  available_memory_mb   = 128
  source_archive_bucket = "${google_storage_bucket.bucket.name}"
  source_archive_object = "${google_storage_bucket_object.archive.name}"
  timeout               = 80

  environment_variables = {
      SLACK_WEBHOOK     = "https://hooks.slack.com/services/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"
  }

  event_trigger {
    event_type  = "providers/cloud.pubsub/eventTypes/topic.publish"
    resource    = "${var.topic_name}"
  }
}