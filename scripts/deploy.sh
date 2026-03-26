#!/bin/bash

set -e

ENVIRONMENT="$1"

if [ -z "$ENVIRONMENT" ]; then
  echo "Usage: ./scripts/deploy.sh <environment>"
  echo "Example: ./scripts/deploy.sh dev"
  exit 1
fi

ENV_DIR="environments/$ENVIRONMENT"

if [ ! -d "$ENV_DIR" ]; then
  echo "Error: Environment directory '$ENV_DIR' does not exist."
  exit 1
fi

echo "Starting Terraform deployment for environment: $ENVIRONMENT"

cd "$ENV_DIR"

echo "Running terraform init..."
terraform init

echo "Running terraform validate..."
terraform validate

echo "Running terraform fmt..."
terraform fmt -recursive

echo "Running terraform plan..."
terraform plan -var-file=terraform.tfvars

echo "Running terraform apply..."
terraform apply -var-file=terraform.tfvars -auto-approve

echo "Deployment complete for environment: $ENVIRONMENT"
