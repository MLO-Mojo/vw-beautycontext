## AWS-Credentials ##############
PROFILE=default
REGION=eu-central-1
################################

## Cloudformation-Credentials###
PROJECT_NAME=vw-beatycontext
################################

## Git-Repository-Credentials###
GITHUB_REPO_NAME='vw-beautycontext'
GITHUB_USER_NAME='MLO-Mojo'
GITHUB_OAUTH_TOKEN='5eb76d0b913f1408de0a5ce784c6b5ed139971c7'
################################

deploy-pipeline-infrastructure:
	@echo "deploy pipeline-infrastructure-stack"
	@aws cloudformation create-stack \
		--stack-name ${PROJECT_NAME}-pipeline-infrastructure \
		--template-body file://cicd/pipeline-infrastructure.yaml \
		--parameters \
				ParameterKey=Project,ParameterValue=${PROJECT_NAME} \
				ParameterKey=OAuthTokenGithub,ParameterValue=${GITHUB_OAUTH_TOKEN} \
		--capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
		--profile ${PROFILE} \
		--region ${REGION}

	@echo "Waiting till all resources have been created... this can take some minutes"
	@aws cloudformation wait stack-create-complete \
		--stack-name ${PROJECT_NAME}-pipeline-infrastructure \
		--profile ${PROFILE} \
		--region ${REGION}
	@echo "successful created!"

deploy-pipeline:
	@echo "deploy pipeline-stack"
	@aws cloudformation create-stack \
		--stack-name ${PROJECT_NAME}-pipeline \
		--template-body file://cicd/pipeline.yaml \
		--parameters \
				ParameterKey=Project,ParameterValue=${PROJECT_NAME} \
				ParameterKey=PipelineInfrastructureStack,ParameterValue=${PROJECT_NAME}-pipeline-infrastructure \
				ParameterKey=GitHubRepoName,ParameterValue=${GITHUB_REPO_NAME} \
				ParameterKey=GitHubOwner,ParameterValue=${GITHUB_USER_NAME} \
		--capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
		--profile ${PROFILE} \
		--region ${REGION}

	@echo "Waiting till all resources have been created... this can take some minutes"
	@aws cloudformation wait stack-create-complete \
		--stack-name ${PROJECT_NAME}-pipeline \
		--profile ${PROFILE} \
		--region ${REGION}
	@echo "successful created!"