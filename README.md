# CI/CD with Google Cloud Workflows

This repo is currently a proof of concept to test cloud-native pipelines in a serverless fashion.

It uses the [Workflows service](https://cloud.google.com/workflows) which allows ordered orchestration of multiple tasks
in a controlled way.

Currently, it has:

- The YAML file needed to declaratively construct the Workflow.
- A cloud function which is written in typescript that will update github statuses.
- A couple of cloudbuild yamls which are used by the service to kickoff builds and deployments.

### Some notes

- Function targets nodejs 14.
- Function needs a personal access token from github to report back the status, with authorisation.

### On the todo list

- Convert much of the infrastructure which has been defined via click ops to terraform.
- Sort out a better way to report statuses back to github which don't involve a user's access token.
