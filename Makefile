vanila-plan:
	@cd eks_vanila && terraform init && terraform plan

vanila-apply:
	@cd eks_vanila && terraform init && terraform apply -auto-approve

vanila-destroy:
	@cd eks_vanila && terraform destroy -auto-approve

vpc:
	@aws ec2 describe-vpcs --endpoint-url=http://localhost:4566 --profile localstack

subnets:
	@aws ec2 describe-subnets --endpoint-url=http://localhost:4566 --profile localstack

eks-coredns-version:
	@aws eks describe-addon-versions \
	--addon-name coredns \
	--kubernetes-version 1.33 \
	--profile personal \
	--region us-east-1

eks-cni-version:
	@aws eks describe-addon-versions \
	--addon-name vpc-cni \
	--kubernetes-version 1.33 \
	--profile personal \
	--region us-east-1

eks-pod-identity-version:
	@aws eks describe-addon-versions \
  --addon-name eks-pod-identity-agent \
  --kubernetes-version 1.33 \
  --profile personal \
  --region us-east-1

eks-kube-proxy-version:
	@aws eks describe-addon-versions \
  --addon-name kube-proxy \
  --kubernetes-version 1.33 \
  --profile personal \
  --region us-east-1