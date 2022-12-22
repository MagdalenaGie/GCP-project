resource "google_dataflow_job" "word_count_job_success" {
  name              = "dataflow-job_word_count"
  template_gcs_path = "gs://dataflow-templates/latest/Word_Count"
  temp_gcs_location = "gs://${var.bucket_name}/dataflow"
  parameters = {
    inputFile = "gs://dataflow-samples/shakespeare/kinglear.txt"
    output    = "gs://${var.bucket_name}/output/my_output"
  }
}