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
      branch          = "^master$"
      comment_control = "COMMENTS_ENABLED_FOR_EXTERNAL_CONTRIBUTORS_ONLY"
    }
  }

  filename = "terraform-plan.yaml"
}

resource "google_cloudbuild_trigger" "determine-differences" {
  name        = "determine-differences"
  description = "This cloudbuilder will compare two files or directories and based on the git hash given and the previous commit, will determine if there are changes with the compared files."

  source_to_build {
    uri       = "https://github.com/jgunnink/workflow-cicd-demo.git"
    ref       = "refs/heads/main"
    repo_type = "GITHUB"
  }

  git_file_source {
    path      = "determineDifferences.yaml"
    uri       = "https://github.com/jgunnink/workflow-cicd-demo.git"
    revision  = "refs/heads/main"
    repo_type = "GITHUB"
  }
}

resource "google_cloudbuild_trigger" "deploy-infrastructure" {
  name        = "deploy-infrastructure"
  description = "This cloudbuilder run terraform apply."

  source_to_build {
    uri       = "https://github.com/jgunnink/workflow-cicd-demo.git"
    ref       = "refs/heads/main"
    repo_type = "GITHUB"
  }

  git_file_source {
    path      = "terraform-apply.yaml"
    uri       = "https://github.com/jgunnink/workflow-cicd-demo.git"
    revision  = "refs/heads/main"
    repo_type = "GITHUB"
  }
}
