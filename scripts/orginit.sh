#!/bin/bash

# Install script
echo "Cleaning previous scratch org..."
sfdx force:org:delete -p -u ApexKit

echo "Creating new scratch org"
sfdx force:org:create --definitionfile config/project-scratch-def.json --setalias ApexKit --nonamespace --setdefaultusername --noancestors

echo "Push unmanaged main metadata"
sfdx force:source:push

echo "Assigning permission set"
sfdx force:user:permset:assign -n Async_Log_Access

echo "opening org"
sfdx force:org:open