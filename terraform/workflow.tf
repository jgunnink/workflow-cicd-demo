resource "google_workflows_workflow" "workflow" {
  name            = var.workflow_name
  region          = "asia-southeast1"
  description     = "CI/CD Pipeline"
  service_account = "projects/${var.project_id}/serviceAccounts/${google_service_account.workflow_runner_service_account.email}"
  source_contents = file("../workflow.yaml")
}
