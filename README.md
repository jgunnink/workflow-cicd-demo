# CI/CD with Google Cloud Workflows

This repo is currently a proof of concept to test cloud-native pipelines in a serverless fashion.

It uses the [Workflows service](https://cloud.google.com/workflows) which allows ordered orchestration of multiple tasks
in a controlled way.

Currently, it has:

- The YAML file needed to declaratively construct the Workflow.
- A cloud function which is written in typescript that will update github statuses.
- A couple of cloudbuild yamls which are used by the service to kickoff builds and deployments.
- Terraform to handle the creation of the required cloud infrastructure to build the service.

### Some notes

- Function targets nodejs 16.
- Function needs a personal access token from github to report back the status, with authorisation. You will need to create a secret in
  secret manager called GITHUB_TOKEN in order for the function to deploy correctly.

### Using terraform

1. The current only manual step is that inside a GCP project you'll need to create a secret with secret manager called GITHUB_TOKEN in order
   to update github statuses.
1. The personal access token from github needs "repo:status" only.
1. The cloud builders rely on a terraform docker image stored in the projects container repository (GCR).

### On the todo list

- [x] Convert much of the infrastructure which has been defined via click ops to terraform.
- [ ] Sort out a better way to report statuses back to github which don't involve a user's access token.
