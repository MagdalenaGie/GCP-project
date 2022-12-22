resource "google_logging_project_sink" "log_sink_to_pub_sub" {
  name        = "log_dataflow_job_results_to_pub_sub_sink"
  destination = "pubsub.googleapis.com/projects/${var.project_id}/topics/${var.topic_name}"
  filter      = "resource.type = dataflow_step AND logName=(\"projects/${var.project_id}/logs/dataflow.googleapis.com%2Fjob-message\") AND ((severity=ERROR AND textPayload=~\"^Workflow failed.*$\") OR (severity=DEBUG AND textPayload=~\"^Executing success step success.*$\"))"
  unique_writer_identity = true
}

resource "google_project_iam_binding" "log_writer_pub_sub" {
  role = "roles/pubsub.editor"

  members = [
    google_logging_project_sink.log_sink_to_pub_sub.writer_identity,
  ]
}

// cloud pub-sub topic for streaming to Log aggregator platform like ELK
resource "google_pubsub_topic" "log_sink_topic" {
  name = "${var.topic_name}"
}