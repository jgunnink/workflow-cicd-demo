resource "google_service_account" "workflow_service" {
  account_id   = "workflow-service"
  display_name = "Workflow CICD Service"
  description  = "Controls the workflow for the cloud pipeline"
}

resource "google_workflows_workflow" "workflow-1" {
  name            = "workflow-1"
  region          = "asia-southeast1"
  description     = "CI/CD Pipeline"
  service_account = google_service_account.workflow_service.id
  source_contents = "../workflow.yaml"
}
