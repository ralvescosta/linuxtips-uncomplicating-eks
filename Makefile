vanila-plan:
	cd eks_vanila && terraform init && terraform plan

vanila-apply:
	cd eks_vanila && terraform init && terraform apply

vanila-destroy:
	cd eks_vanila && terraform destroy