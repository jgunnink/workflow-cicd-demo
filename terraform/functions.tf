resource "google_cloudfunctions_function" "notify-github" {
  available_memory_mb = "128"
  entry_point         = "notifyGithub"

  https_trigger_url = "https://${var.region}-${var.project_id}.cloudfunctions.net/notify-github"
  ingress_settings  = "ALLOW_ALL"

  labels = {
    deployed-with = "terraform"
    updated-with  = "cli-gcloud"
  }

  name                  = "notify-github"
  project               = var.project_id
  region                = var.region
  runtime               = "nodejs14"
  service_account_email = google_service_account.notify_github_sa.email
  timeout               = 60
  trigger_http          = true

  source_archive_bucket = "gcf-sources-924919904854-australia-southeast1"
  source_archive_object = "notify-github-fd1bee74-f30c-4aea-9972-ba5116e6da38/version-1/function-source.zip"
}
