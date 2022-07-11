# UNMANAGED for use with scratch org

# Install scriptecho "Cleaning previous scratch org..."
echo "Cleaning previous scratch org..."
sfdx force:org:delete -p -u ASL

echo "Creating new scratch org"
sfdx force:org:create --definitionfile config/project-scratch-def.json --setalias ASL --nonamespace --setdefaultusername --noancestors

# For use with namespaced scratch org n package development process
echo "Deploying unmanaged main metadata"
sfdx force:source:deploy -p force-app --tracksource

# To install sample action plan template
echo "Loading sample data"
sfdx force:data:tree:import -p ./data/action-plan-data-plan.json

echo "opening org"
sfdx force:org:open