vanila-plan:
	cd eks_vanila && terraform init && terraform plan

vanila-apply:
	cd eks_vanila && terraform init && terraform apply

vanila-destroy:
	cd eks_vanila && terraform destroy

vpc:
	aws ec2 describe-vpcs --endpoint-url=http://localhost:4566 --profile localstack

subnets:
	aws ec2 describe-subnets --endpoint-url=http://localhost:4566 --profile localstack
