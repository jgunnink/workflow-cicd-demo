resource "google_workflows_workflow" "workflow-2" {
  name            = "workflow-2"
  region          = "asia-southeast1"
  description     = "CI/CD Pipeline"
  service_account = "projects/${var.project_id}/serviceAccounts/${google_service_account.workflow-runner-service-account.email}"
  source_contents = file("../workflow.yaml")
}
