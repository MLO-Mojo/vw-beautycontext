## vw-beautycontext - wordpress setup

The Project contains the IaC for a simple wordpress setup with ecs.
For the deployment of the IaC, AWS Codepipeline is used.

### How to deploy it:

1. install make on your computer (if it doesn't already exist)
2. in the root-folder of this project, open the [Makefile](./Makefile)
2.1 Adapt the following variables for your needs: 
* `PROFILE` = Enter your local AWS profile
* `REGION` = Enter the region for the setup (default=Frankfurt)
* `REGION` = Enter the region for the setup (default=Frankfurt)
* `GITHUB_REPO_NAME` = Enter the name of the gitHub repository
* `GITHUB_USER_NAME` = Enter the username of the gitHub-account
* `GITHUB_OAUTH_TOKEN` = Enter the OAuth-Token of your gitHub account
