#!/bin/bash

set -e

ENVIRONMENT="$1"

if [ -z "$ENVIRONMENT" ]; then
  echo "Usage: ./scripts/destroy.sh <environment>"
  echo "Example: ./scripts/destroy.sh dev"
  exit 1
fi

ENV_DIR="environments/$ENVIRONMENT"

if [ ! -d "$ENV_DIR" ]; then
  echo "Error: Environment directory '$ENV_DIR' does not exist."
  exit 1
fi

echo "You are about to destroy the Terraform-managed infrastructure for environment: $ENVIRONMENT"
read -p "Type 'yes' to confirm: " CONFIRMATION

if [ "$CONFIRMATION" != "yes" ]; then
  echo "Destroy cancelled."
  exit 0
fi

cd "$ENV_DIR"

echo "Running terraform destroy..."
terraform destroy -var-file=terraform.tfvars -auto-approve

echo "Destroy complete for environment: $ENVIRONMENT"
