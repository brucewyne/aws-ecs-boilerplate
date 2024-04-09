# An AWS ECS Boilerplate

This is meant to serve as a recipe for setting up a Production + Development Infrastructure on ECS.

## Prerequisites

* an IAM service account
  * You should have `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` stored as a GitHub secret. Either in the repository, or as an Org secret in GitHub
* an S3 bucket already created named `myorg-terraform-infrastructure` to maintain the terraform state.
  * You'll likely need to create a unique bucket name, then update that in both `./terraform/dev/main.tf` and `./terraform/production/main.tf`

This is meant to work in conjunction with (insert link), which would deploy your application to this ECS environment

This serves only as a starting point. There's certainly security best practices that may or may not be present here.
