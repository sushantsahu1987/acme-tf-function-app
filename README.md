terraform apply -var-file=variables.tfvars

az functionapp deployment list-publishing-profiles --name acme-test-function-app --resource-group acme-test-resource-group 
