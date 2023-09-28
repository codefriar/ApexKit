#!/bin/bash

# Install script
echo "Cleaning previous scratch org..."
sf org delete scratch --no-prompt --target-org ApexKit

echo "Creating new scratch org"
sf org create scratch --definition-file config/project-scratch-def.json --duration-days 10 --alias ApexKit --no-namespace --set-default --no-ancestors

echo "Push unmanaged main metadata"
sf project deploy start

echo "Assigning permission set"
sf org assign permset --name Async_Log_Access

# echo "Adding sample data"
# sf apex run --file ./data/Apexkit-data-plan.json

echo "Opening org"
sf org open

echo "Org is set up"