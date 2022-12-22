terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.20.0"
    }
  }
  backend "local" {}
}

provider "google" {
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

resource "random_id" "random_suffix" {
  byte_length = 4
}

locals {
  bucket_name = "tmp-dir-bucket-${random_id.random_suffix.hex}"
}

module "storage" {
  source        = "./modules/storage"
  bucket_name   = local.bucket_name
}

module "dataflow" {
  source                = "./modules/dataflow"
  bucket_name           = local.bucket_name
}

module "log_sink" {
  source                = "./modules/log_sink"
  project_id            = var.project_id
  topic_name            = var.topic_name
}

module "cloud_function" {
  source                = "./modules/cloud_function"
  topic_name            = var.topic_name
}