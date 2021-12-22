resource "google_cloudbuild_trigger" "kickoff-workflow" {
  name        = "kickoff-workflow"
  description = "On pushes to the master branch, this trigger will activate, executing the workflow to run the pipeline"

  github {
    owner = var.repo_owner
    name  = var.repo_name

    push {
      branch = "^master$"
    }
  }

  filename = "kickoff-workflow.yaml"
}

resource "google_cloudbuild_trigger" "terraform-plan-ci" {
  name        = "terraform-plan-ci"
  description = "Run terraform plan on pull requests against master"

  github {
    owner = var.repo_owner
    name  = var.repo_name

    pull_request {
      branch       = "^master$"
      comment_control = "COMMENTS_ENABLED_FOR_EXTERNAL_CONTRIBUTORS_ONLY"
    }
  }

  filename = "terraform-plan.yaml"
}
