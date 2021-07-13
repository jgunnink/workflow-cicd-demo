variable "project_id" {
  description = "The project ID in Google Cloud to use for these resources."
}

variable "region" {
  description = "The region in Google Cloud where the resources will be deployed."
  default     = "australia-southeast1"
}

variable "repo_name" {
  description = "The name of the respository for cloudbuild to use with triggers"
}

variable "repo_owner" {
  description = "The name of the owner of the repo. For example, this could be GoogleCloudPlatform or jgunnink"
}
