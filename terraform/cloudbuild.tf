resource "google_cloudbuild_trigger" "filename-trigger" {
  name        = "kickoff-workflow"
  description = "On pushes to the master branch, this trigger will activate, executing the workflow to run the pipeline"

  github {
    owner = var.repo_owner
    name  = var.repo_name

    push {
      branch       = "^master$"
      invert_regex = false
    }
  }

  filename = "../kickoff-workflow.yaml"

  #Assign service account
}
