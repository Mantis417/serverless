#!/bin/bash

# Set variables for the template file and stack name
TEMPLATE_FILE="cloudform.yml"  # Change this to the path of your CloudFormation template file
STACK_NAME="serverless1"  # Change this to your stack name

# Deploy the CloudFormation stack using the variables from .env
aws cloudformation deploy \
  --template-file "$TEMPLATE_FILE" \
  --stack-name "$STACK_NAME" \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    GitHubOwner="mantis417" \
    GitHubRepo="mantis417/serverless" \
    GitHubBranch="main" \

# Check if deployment was successful
if [ $? -eq 0 ]; then
  echo "CloudFormation stack deployed successfully!"
else
  echo "Error: CloudFormation stack deployment failed."
  exit 1
fi

echo "This is the contact form URL: $(aws cloudformation describe-stacks --stack-name $STACK_NAME --query "Stacks[0].Outputs[0].OutputValue" --output text)"