resource "google_project_iam_custom_role" "workflow_cloudbuild_invoker" {
  description = "The custom role to enable invoking cloudbuild runs from the workflow service."
  permissions = ["cloudbuild.builds.create", "cloudbuild.builds.get"]
  project     = var.project_id
  role_id     = "workflow_cloudbuild_invoker"
  title       = "Workflow Cloudbuild Invoker"
}

resource "google_service_account" "workflow-runner-service-account" {
  account_id   = "workflow-service"
  description  = "Controls the workflow for the cloud pipeline"
  display_name = "workflow-service"
  project      = var.project_id
}

# google_project_iam_member: Non-authoritative.
# Updates the IAM policy to grant a role to a new member. Other members for the role for the project are preserved.
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam#google_project_iam_member
resource "google_project_iam_member" "workflow_cloudbuild_invoker_custom" {
  member  = "serviceAccount:workflow-service@cloud-pipeline-dev.iam.gserviceaccount.com"
  project = "cloud-pipeline-dev"
  role    = "projects/cloud-pipeline-dev/roles/workflow_cloudbuild_invoker"
}

resource "google_project_iam_member" "workflow_cloudfunction_invoker" {
  member  = "serviceAccount:workflow-service@cloud-pipeline-dev.iam.gserviceaccount.com"
  project = "cloud-pipeline-dev"
  role    = "roles/cloudfunctions.invoker"
}

resource "google_project_iam_member" "cloudbuild_administer_cloudfunctions" {
  member  = "serviceAccount:924919904854@cloudbuild.gserviceaccount.com"
  project = "cloud-pipeline-dev"
  role    = "roles/cloudfunctions.admin"
}

resource "google_project_iam_member" "cloudbuild_edit_workflows" {
  member  = "serviceAccount:924919904854@cloudbuild.gserviceaccount.com"
  project = "cloud-pipeline-dev"
  role    = "roles/workflows.editor"
}

resource "google_project_iam_member" "cloudbuild_invoke_workflows" {
  member  = "serviceAccount:924919904854@cloudbuild.gserviceaccount.com"
  project = "cloud-pipeline-dev"
  role    = "roles/workflows.invoker"
}
