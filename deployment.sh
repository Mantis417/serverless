#!/bin/bash

# Deploy the CloudFormation
aws cloudformation deploy \
  --template-file "cloudform.yml" \
  --stack-name "serverless" \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    GitHubRepository="mantis417/serverless" \
    FrMail="christoffer.r.soderstrom@gmail.com" \
    TillMail="chrisan12345@gmail.com" \

# Check if deployment was successful
if [ $? -eq 0 ]; then
  echo "CloudFormation stack deployed successfully!"
else
  echo "Error: CloudFormation stack deployment failed."
  exit 1
fi

# Hämta CloudFront Distribution ID (ersätt med din egen distribution ID om du har det)
DISTRIBUTION_ID=$(aws cloudfront list-distributions --query "DistributionList.Items[0].Id" --output text)

# Hämta CloudFront Distribution DomainName
CLOUDFRONT_URL=$(aws cloudfront get-distribution --id $DISTRIBUTION_ID --query "Distribution.DomainName" --output text)

# Visa URL
echo "CloudFront URL: https://$CLOUDFRONT_URL"