PROFILE=default
REGION=eu-central-1

PROJECT_NAME=vw-beatycontext

deploy-pipeline-infrastructure:
	@echo "deploy pipeline-infrastructure"
	@aws cloudformation create-stack \
		--stack-name ${PROJECT_NAME}-pipeline-infrastructure \
		--template-body file://cicd/pipeline-infrastructure.yaml \
		--parameters \
				ParameterKey=Project,ParameterValue=${PROJECT_NAME} \
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
	@echo "deploy pipeline"
	@aws cloudformation create-stack \
		--stack-name ${PROJECT_NAME}-pipeline \
		--template-body file://cicd/pipeline.yaml \
		--parameters \
				ParameterKey=Project,ParameterValue=${PROJECT_NAME} \
		--capabilities CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND \
		--profile ${PROFILE} \
		--region ${REGION}

	@echo "Waiting till all resources have been created... this can take some minutes"
	@aws cloudformation wait stack-create-complete \
		--stack-name ApiGwDeploymentLambdaStack \
		--profile ${PROFILE} \
		--region ${REGION}
	@echo "successful created!"
