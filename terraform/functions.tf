resource "google_cloudfunctions_function" "notify-github" {
  available_memory_mb = "128"
  entry_point         = "notifyGithub"

  https_trigger_url = "https://${var.region}-${var.project_id}.cloudfunctions.net/notify-github"
  ingress_settings  = "ALLOW_ALL"

  labels = {
    deployment-tool = "cli-gcloud"
  }

  name                  = "notify-github"
  project               = var.project_id
  region                = var.region
  runtime               = "nodejs14"
  # TODO: Change this to a custom service account.
  service_account_email = "${var.project_id}@appspot.gserviceaccount.com"
  timeout               = 60
  trigger_http          = true
}
