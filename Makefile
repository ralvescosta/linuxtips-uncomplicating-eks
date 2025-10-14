localstack:
	@localstack start -d

vanila-plan:
	@cd eks_vanila && terraform init && terraform plan

vanila-apply:
	@cd eks_vanila && terraform init && terraform apply -auto-approve

vanila-destroy:
	@cd eks_vanila && terraform destroy -auto-approve

vanila-update:
	@cd eks_vanila && terraform init -upgrade

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

localstack-coredns-version:
	@aws eks describe-addon-versions \
	--addon-name coredns \
	--kubernetes-version 1.33 \
	--profile localstack \
	--endpoint-url=http://localhost:4566 \
	--region us-east-1

localstack-cni-version:
	@aws eks describe-addon-versions \
	--addon-name vpc-cni \
	--kubernetes-version 1.33 \
	--profile localstack \
	--endpoint-url=http://localhost:4566 \
	--region us-east-1

localstack-pod-identity-version:
	@aws eks describe-addon-versions \
  --addon-name eks-pod-identity-agent \
  --kubernetes-version 1.33 \
	--profile localstack \
	--endpoint-url=http://localhost:4566 \
  --region us-east-1

localstack-kube-proxy-version:
	@aws eks describe-addon-versions \
  --addon-name kube-proxy \
  --kubernetes-version 1.33 \
	--profile localstack \
	--endpoint-url=http://localhost:4566 \
  --region us-east-1

localstack-tf-state:
	@aws --profile localstack \
		--region us-east-1 \
		--endpoint-url http://localhost:4566 \
	s3api create-bucket \
	--bucket linuxtips-uncomplicating-eks-tf-state; \
	aws --profile localstack \
		--region us-east-1 \
		--endpoint-url http://localhost:4566 \
	s3api put-bucket-versioning \
	--bucket linuxtips-uncomplicating-eks-tf-state \
	--versioning-configuration Status=Enabled

localstack-kubeconfig:
	@aws eks update-kubeconfig \
	--name linuxtips-uncomplicating-eks \
	--region us-east-1 \
	--profile localstack \
	--endpoint-url http://localhost:4566