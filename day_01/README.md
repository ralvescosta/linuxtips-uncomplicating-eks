> terraform init -backend-config=environment/prod/backend.tfvars

> terraform apply --auto-approve -var-file=environment/prod/terraform.tfvars