resource "google_project_iam_custom_role" "workflow_cloudbuild_invoker" {
  description = "The custom role to enable invoking cloudbuild runs from the workflow service."
  permissions = ["cloudbuild.builds.create", "cloudbuild.builds.get"]
  project     = var.project_id
  role_id     = "workflow_cloudbuild_invoker"
  title       = "Workflow Cloudbuild Invoker"
}

resource "google_service_account" "workflow_runner_service_account" {
  account_id   = "workflow-service"
  description  = "Controls the workflow for the cloud pipeline"
  display_name = "workflow-service"
  project      = var.project_id
}

resource "google_service_account" "notify_github_sa" {
  account_id   = "notify-github"
  description  = "Controls the workflow for the cloud pipeline"
  display_name = "notify-github"
  project      = var.project_id
}

# google_project_iam_member: Non-authoritative.
# Updates the IAM policy to grant a role to a new member. Other members for the role for the project are preserved.
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam#google_project_iam_member
resource "google_project_iam_member" "workflow_cloudbuild_invoker_custom" {
  member  = "serviceAccount:${google_service_account.workflow_runner_service_account.email}"
  project = var.project_id
  role    = "projects/cloud-pipeline-dev/roles/workflow_cloudbuild_invoker"
}

resource "google_project_iam_member" "workflow_cloudfunction_invoker" {
  member  = "serviceAccount:${google_service_account.workflow_runner_service_account.email}"
  project = var.project_id
  role    = "roles/cloudfunctions.invoker"
}

resource "google_project_iam_member" "notify_github_function_runner" {
  member  = "serviceAccount:${google_service_account.notify_github_sa.email}"
  project = var.project_id
  role    = "roles/secretmanager.secretAccessor"
}

resource "google_project_iam_member" "cloudbuild_administer_cloudfunctions" {
  member  = "serviceAccount:924919904854@cloudbuild.gserviceaccount.com"
  project = var.project_id
  role    = "roles/cloudfunctions.admin"
}

resource "google_project_iam_member" "cloudbuild_edit_workflows" {
  member  = "serviceAccount:924919904854@cloudbuild.gserviceaccount.com"
  project = var.project_id
  role    = "roles/workflows.editor"
}

resource "google_project_iam_member" "cloudbuild_invoke_workflows" {
  member  = "serviceAccount:924919904854@cloudbuild.gserviceaccount.com"
  project = var.project_id
  role    = "roles/workflows.invoker"
}
