.PHONY: help update-localstack-config update-vpc update-subnets update-addons

# Default profile and endpoint for LocalStack
LOCALSTACK_ENDPOINT := http://localhost:4566
LOCALSTACK_PROFILE := localstack
AWS_PROFILE := personal
AWS_REGION := us-east-1
K8S_VERSION := 1.33
TFVARS_FILE := terraform.tfvars

help: ## Show this help message
	@echo "Available targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2}'

update-localstack-config: ## Update terraform.tfvars with current LocalStack VPC, subnets, and addon versions
	@echo "🔄 Updating terraform.tfvars with LocalStack configuration..."
	@$(MAKE) update-vpc
	@$(MAKE) update-subnets
	@$(MAKE) update-addons
	@echo "✅ Configuration updated successfully!"

update-vpc: ## Update VPC ID from LocalStack
	@echo "📡 Fetching VPC ID from LocalStack..."
	@VPC_ID=$$(aws ec2 describe-vpcs \
		--endpoint-url=$(LOCALSTACK_ENDPOINT) \
		--profile $(LOCALSTACK_PROFILE) \
		--query 'Vpcs[0].VpcId' \
		--output text 2>/dev/null); \
	if [ -z "$$VPC_ID" ] || [ "$$VPC_ID" = "None" ]; then \
		echo "❌ Error: No VPC found in LocalStack"; \
		exit 1; \
	fi; \
	echo "   VPC ID: $$VPC_ID"; \
	sed -i.bak "s|vpc_id = \"vpc-[a-z0-9]*\"|vpc_id = \"$$VPC_ID\"|g" $(TFVARS_FILE) && rm -f $(TFVARS_FILE).bak

update-subnets: ## Update subnet IDs from LocalStack
	@echo "📡 Fetching subnet IDs from LocalStack..."
	@PUBLIC_SUBNETS=$$(aws ec2 describe-subnets \
		--endpoint-url=$(LOCALSTACK_ENDPOINT) \
		--profile $(LOCALSTACK_PROFILE) \
		--filters "Name=tag:Type,Values=public" \
		--query 'Subnets[*].SubnetId' \
		--output text 2>/dev/null | tr '\t' '\n' | head -2); \
	PRIVATE_SUBNETS=$$(aws ec2 describe-subnets \
		--endpoint-url=$(LOCALSTACK_ENDPOINT) \
		--profile $(LOCALSTACK_PROFILE) \
		--filters "Name=tag:Type,Values=private" \
		--query 'Subnets[*].SubnetId' \
		--output text 2>/dev/null | tr '\t' '\n' | head -2); \
	POD_SUBNETS=$$(aws ec2 describe-subnets \
		--endpoint-url=$(LOCALSTACK_ENDPOINT) \
		--profile $(LOCALSTACK_PROFILE) \
		--filters "Name=tag:Type,Values=pod" \
		--query 'Subnets[*].SubnetId' \
		--output text 2>/dev/null | tr '\t' '\n' | head -2); \
	if [ -z "$$PUBLIC_SUBNETS" ]; then \
		echo "⚠️  Warning: No public subnets found, using first 2 available subnets"; \
		PUBLIC_SUBNETS=$$(aws ec2 describe-subnets \
			--endpoint-url=$(LOCALSTACK_ENDPOINT) \
			--profile $(LOCALSTACK_PROFILE) \
			--query 'Subnets[0:2].SubnetId' \
			--output text 2>/dev/null); \
	fi; \
	if [ -z "$$PRIVATE_SUBNETS" ]; then \
		echo "⚠️  Warning: No private subnets found, using next 2 available subnets"; \
		PRIVATE_SUBNETS=$$(aws ec2 describe-subnets \
			--endpoint-url=$(LOCALSTACK_ENDPOINT) \
			--profile $(LOCALSTACK_PROFILE) \
			--query 'Subnets[2:4].SubnetId' \
			--output text 2>/dev/null); \
	fi; \
	if [ -z "$$POD_SUBNETS" ]; then \
		echo "⚠️  Warning: No pod subnets found, using next 2 available subnets"; \
		POD_SUBNETS=$$(aws ec2 describe-subnets \
			--endpoint-url=$(LOCALSTACK_ENDPOINT) \
			--profile $(LOCALSTACK_PROFILE) \
			--query 'Subnets[4:6].SubnetId' \
			--output text 2>/dev/null); \
	fi; \
	PUBLIC_SUBNET_1=$$(echo "$$PUBLIC_SUBNETS" | sed -n '1p'); \
	PUBLIC_SUBNET_2=$$(echo "$$PUBLIC_SUBNETS" | sed -n '2p'); \
	PRIVATE_SUBNET_1=$$(echo "$$PRIVATE_SUBNETS" | sed -n '1p'); \
	PRIVATE_SUBNET_2=$$(echo "$$PRIVATE_SUBNETS" | sed -n '2p'); \
	POD_SUBNET_1=$$(echo "$$POD_SUBNETS" | sed -n '1p'); \
	POD_SUBNET_2=$$(echo "$$POD_SUBNETS" | sed -n '2p'); \
	echo "   Public Subnets: $$PUBLIC_SUBNET_1, $$PUBLIC_SUBNET_2"; \
	echo "   Private Subnets: $$PRIVATE_SUBNET_1, $$PRIVATE_SUBNET_2"; \
	echo "   Pod Subnets: $$POD_SUBNET_1, $$POD_SUBNET_2"; \
	awk -v ps1="$$PUBLIC_SUBNET_1" -v ps2="$$PUBLIC_SUBNET_2" \
		-v pvs1="$$PRIVATE_SUBNET_1" -v pvs2="$$PRIVATE_SUBNET_2" \
		-v pods1="$$POD_SUBNET_1" -v pods2="$$POD_SUBNET_2" ' \
		/^public_subnets = \[/ { \
			print "public_subnets = ["; \
			print "  \"" ps1 "\","; \
			print "  \"" ps2 "\","; \
			print "]"; \
			next; \
		} \
		/^  "subnet-[a-z0-9]*",$$/ && in_public { next; } \
		/^\]$$/ && in_public { in_public=0; next; } \
		/^public_subnets = \[/ { in_public=1; } \
		/^private_subnets = \[/ { \
			print "private_subnets = ["; \
			print "  \"" pvs1 "\","; \
			print "  \"" pvs2 "\""; \
			print "]"; \
			next; \
		} \
		/^  "subnet-[a-z0-9]*",$$/ && in_private { next; } \
		/^  "subnet-[a-z0-9]*"$$/ && in_private { next; } \
		/^\]$$/ && in_private { in_private=0; next; } \
		/^private_subnets = \[/ { in_private=1; } \
		/^pod_subnets = \[/ { \
			print "pod_subnets = ["; \
			print "  \"" pods1 "\","; \
			print "  \"" pods2 "\""; \
			print "]"; \
			next; \
		} \
		/^  "subnet-[a-z0-9]*",$$/ && in_pod { next; } \
		/^  "subnet-[a-z0-9]*"$$/ && in_pod { next; } \
		/^\]$$/ && in_pod { in_pod=0; next; } \
		/^pod_subnets = \[/ { in_pod=1; } \
		{ print; } \
	' $(TFVARS_FILE) > $(TFVARS_FILE).tmp && mv $(TFVARS_FILE).tmp $(TFVARS_FILE)

update-addons: ## Update EKS addon versions from AWS
	@echo "📡 Fetching latest EKS addon versions..."
	@CNI_VERSION=$$(aws eks describe-addon-versions \
		--addon-name vpc-cni \
		--kubernetes-version $(K8S_VERSION) \
		--profile $(AWS_PROFILE) \
		--region $(AWS_REGION) \
		--query 'addons[0].addonVersions[0].addonVersion' \
		--output text 2>/dev/null); \
	COREDNS_VERSION=$$(aws eks describe-addon-versions \
		--addon-name coredns \
		--kubernetes-version $(K8S_VERSION) \
		--profile $(AWS_PROFILE) \
		--region $(AWS_REGION) \
		--query 'addons[0].addonVersions[0].addonVersion' \
		--output text 2>/dev/null); \
	KUBEPROXY_VERSION=$$(aws eks describe-addon-versions \
		--addon-name kube-proxy \
		--kubernetes-version $(K8S_VERSION) \
		--profile $(AWS_PROFILE) \
		--region $(AWS_REGION) \
		--query 'addons[0].addonVersions[0].addonVersion' \
		--output text 2>/dev/null); \
	POD_IDENTITY_VERSION=$$(aws eks describe-addon-versions \
		--addon-name eks-pod-identity-agent \
		--kubernetes-version $(K8S_VERSION) \
		--profile $(AWS_PROFILE) \
		--region $(AWS_REGION) \
		--query 'addons[0].addonVersions[0].addonVersion' \
		--output text 2>/dev/null); \
	if [ ! -z "$$CNI_VERSION" ] && [ "$$CNI_VERSION" != "None" ]; then \
		echo "   VPC CNI: $$CNI_VERSION"; \
		sed -i.bak "s|addon_cni_version=\"v[^\"]*\"|addon_cni_version=\"$$CNI_VERSION\"|g" $(TFVARS_FILE) && rm -f $(TFVARS_FILE).bak; \
	else \
		echo "   ⚠️  Could not fetch VPC CNI version"; \
	fi; \
	if [ ! -z "$$COREDNS_VERSION" ] && [ "$$COREDNS_VERSION" != "None" ]; then \
		echo "   CoreDNS: $$COREDNS_VERSION"; \
		sed -i.bak "s|addon_coredns_version=\"v[^\"]*\"|addon_coredns_version=\"$$COREDNS_VERSION\"|g" $(TFVARS_FILE) && rm -f $(TFVARS_FILE).bak; \
	else \
		echo "   ⚠️  Could not fetch CoreDNS version"; \
	fi; \
	if [ ! -z "$$KUBEPROXY_VERSION" ] && [ "$$KUBEPROXY_VERSION" != "None" ]; then \
		echo "   Kube-Proxy: $$KUBEPROXY_VERSION"; \
		sed -i.bak "s|addon_kubeproxy_version=\"v[^\"]*\"|addon_kubeproxy_version=\"$$KUBEPROXY_VERSION\"|g" $(TFVARS_FILE) && rm -f $(TFVARS_FILE).bak; \
	else \
		echo "   ⚠️  Could not fetch Kube-Proxy version"; \
	fi; \
	if [ ! -z "$$POD_IDENTITY_VERSION" ] && [ "$$POD_IDENTITY_VERSION" != "None" ]; then \
		echo "   Pod Identity: $$POD_IDENTITY_VERSION"; \
		sed -i.bak "s|addon_pod_identity_version=\"v[^\"]*\"|addon_pod_identity_version=\"$$POD_IDENTITY_VERSION\"|g" $(TFVARS_FILE) && rm -f $(TFVARS_FILE).bak; \
	else \
		echo "   ⚠️  Could not fetch Pod Identity version"; \
	fi

update-vpc-localstack: ## Update VPC ID from LocalStack (same as update-vpc)
	@$(MAKE) update-vpc

update-subnets-localstack: ## Update subnet IDs from LocalStack (same as update-subnets)
	@$(MAKE) update-subnets

# Terraform commands
init: ## Initialize Terraform
	terraform init

plan: ## Run Terraform plan
	terraform plan

apply: ## Apply Terraform changes
	terraform apply

destroy: ## Destroy Terraform resources
	terraform destroy

fmt: ## Format Terraform files
	terraform fmt -recursive

validate: ## Validate Terraform files
	terraform validate
