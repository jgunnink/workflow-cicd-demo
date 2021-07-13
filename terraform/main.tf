terraform {
  #backend "gcs" {
  #  # Bucket is passed in via cli arg. Eg, terraform initi -reconfigure -backend-configuration=dev.tfbackend
  #}

  required_version = "1.0.2"

}

provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}
