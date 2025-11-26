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
	@$(MAKE) update-use_localstack
	@$(MAKE) update-backend.tf
	@$(MAKE) s3_tf_state
	@$(MAKE) update-vpc
	@$(MAKE) update-subnets
	@$(MAKE) update-addons
	@echo "✅ Configuration updated successfully!"

update-use_localstack:
	@echo "🔄 Setting use_localstack to true in terraform.tfvars..."
	@sed -i.bak "s|use_localstack = false|use_localstack = true|g" $(TFVARS_FILE) && rm -f $(TFVARS_FILE).bak
	@echo "✅ use_localstack set to true."

update-backend.tf: ## Update backend.tf to use LocalStack configuration
	@echo "🔄 Updating backend.tf for LocalStack..."
	@sed -i.bak \
		-e '4s/^    bucket/    # bucket/' \
		-e '5s/^    key/    # key/' \
		-e '6s/^    region/    # region/' \
		-e '7s/^    profile/    # profile/' \
		-e '10s/^    # bucket/    bucket/' \
		-e '11s/^    # key/    key/' \
		-e '12s/^    # region/    region/' \
		-e '13s/^    # profile/    profile/' \
		-e '14s/^    # endpoints/    endpoints/' \
		-e '15s/^    #   s3/      s3/' \
		-e '16s/^    #   sts/      sts/' \
		-e '17s/^    # }/    }/' \
		backend.tf && rm -f backend.tf.bak
	@echo "✅ backend.tf updated for LocalStack."

restore-aws-backend: ## Restore backend.tf to use AWS configuration
	@echo "🔄 Restoring backend.tf for AWS..."
	@sed -i.bak \
		-e '4s/^    # bucket/    bucket/' \
		-e '5s/^    # key/    key/' \
		-e '6s/^    # region/    region/' \
		-e '7s/^    # profile/    profile/' \
		-e '10s/^    bucket/    # bucket/' \
		-e '11s/^    key/    # key/' \
		-e '12s/^    region/    # region/' \
		-e '13s/^    profile/    # profile/' \
		-e '14s/^    endpoints/    # endpoints/' \
		-e '15s/^      s3/    #   s3/' \
		-e '16s/^      sts/    #   sts/' \
		-e '17s/^    }/    # }/' \
		backend.tf && rm -f backend.tf.bak
	@sed -i.bak "s|use_localstack = true|use_localstack = false|g" $(TFVARS_FILE) && rm -f $(TFVARS_FILE).bak
	@echo "✅ backend.tf restored for AWS."

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
	echo "✅ VPC ID updated."

update-subnets: ## Update subnet IDs from LocalStack
	@echo "📡 Fetching subnet IDs from LocalStack..."
	@ALL_SUBNETS=$$(aws ec2 describe-subnets \
		--endpoint-url=$(LOCALSTACK_ENDPOINT) \
		--profile $(LOCALSTACK_PROFILE) \
		--query 'Subnets[*].SubnetId' \
		--output text 2>/dev/null); \
	if [ -z "$$ALL_SUBNETS" ]; then \
		echo "❌ Error: No subnets found in LocalStack"; \
		exit 1; \
	fi; \
	PUBLIC_SUBNET_1=$$(echo "$$ALL_SUBNETS" | awk '{print $$1}'); \
	PUBLIC_SUBNET_2=$$(echo "$$ALL_SUBNETS" | awk '{print $$2}'); \
	PRIVATE_SUBNET_1=$$(echo "$$ALL_SUBNETS" | awk '{print $$3}'); \
	PRIVATE_SUBNET_2=$$(echo "$$ALL_SUBNETS" | awk '{print $$4}'); \
	POD_SUBNET_1=$$(echo "$$ALL_SUBNETS" | awk '{print $$5}'); \
	POD_SUBNET_2=$$(echo "$$ALL_SUBNETS" | awk '{print $$6}'); \
	if [ -z "$$PUBLIC_SUBNET_1" ] || [ -z "$$PUBLIC_SUBNET_2" ]; then \
		echo "❌ Error: Not enough subnets found (need at least 6)"; \
		exit 1; \
	fi; \
	echo "   Public Subnets: $$PUBLIC_SUBNET_1, $$PUBLIC_SUBNET_2"; \
	echo "   Private Subnets: $$PRIVATE_SUBNET_1, $$PRIVATE_SUBNET_2"; \
	echo "   Pod Subnets: $$POD_SUBNET_1, $$POD_SUBNET_2"; \
	TEMP_FILE=$$(mktemp); \
	awk -v ps1="$$PUBLIC_SUBNET_1" -v ps2="$$PUBLIC_SUBNET_2" \
		-v pv1="$$PRIVATE_SUBNET_1" -v pv2="$$PRIVATE_SUBNET_2" \
		-v pd1="$$POD_SUBNET_1" -v pd2="$$POD_SUBNET_2" ' \
		BEGIN { in_public=0; in_private=0; in_pod=0; skip_lines=0 } \
		/^public_subnets = \[/ { \
			print "public_subnets = ["; \
			print "  \"" ps1 "\","; \
			print "  \"" ps2 "\","; \
			print "]"; \
			in_public=1; \
			skip_lines=1; \
			next; \
		} \
		/^private_subnets = \[/ { \
			print "private_subnets = ["; \
			print "  \"" pv1 "\","; \
			print "  \"" pv2 "\""; \
			print "]"; \
			in_private=1; \
			in_public=0; \
			skip_lines=1; \
			next; \
		} \
		/^pod_subnets = \[/ { \
			print "pod_subnets = ["; \
			print "  \"" pd1 "\","; \
			print "  \"" pd2 "\""; \
			print "]"; \
			in_pod=1; \
			in_private=0; \
			skip_lines=1; \
			next; \
		} \
		/^\]/ { \
			if (skip_lines == 1) { \
				skip_lines=0; \
				in_public=0; \
				in_private=0; \
				in_pod=0; \
				next; \
			} \
		} \
		skip_lines == 1 { next; } \
		{ print; } \
	' $(TFVARS_FILE) > $$TEMP_FILE && mv $$TEMP_FILE $(TFVARS_FILE)
	echo "✅ Subnet IDs updated."

update-addons: ## Update EKS addon versions from AWS
	@echo "📡 Fetching latest EKS addon versions..."
	@CNI_VERSION=$$(aws eks describe-addon-versions \
		--addon-name vpc-cni \
		--kubernetes-version $(K8S_VERSION) \
		--profile $(AWS_PROFILE) \
		--endpoint-url=$(LOCALSTACK_ENDPOINT) \
		--region $(AWS_REGION) \
		--query 'addons[0].addonVersions[0].addonVersion' \
		--output text 2>/dev/null); \
	COREDNS_VERSION=$$(aws eks describe-addon-versions \
		--addon-name coredns \
		--kubernetes-version $(K8S_VERSION) \
		--profile $(AWS_PROFILE) \
		--endpoint-url=$(LOCALSTACK_ENDPOINT) \
		--region $(AWS_REGION) \
		--query 'addons[0].addonVersions[0].addonVersion' \
		--output text 2>/dev/null); \
	KUBEPROXY_VERSION=$$(aws eks describe-addon-versions \
		--addon-name kube-proxy \
		--kubernetes-version $(K8S_VERSION) \
		--profile $(AWS_PROFILE) \
		--endpoint-url=$(LOCALSTACK_ENDPOINT) \
		--region $(AWS_REGION) \
		--query 'addons[0].addonVersions[0].addonVersion' \
		--output text 2>/dev/null); \
	POD_IDENTITY_VERSION=$$(aws eks describe-addon-versions \
		--addon-name eks-pod-identity-agent \
		--kubernetes-version $(K8S_VERSION) \
		--profile $(AWS_PROFILE) \
		--endpoint-url=$(LOCALSTACK_ENDPOINT) \
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
	echo "✅ Addon versions updated."

update-vpc-localstack: ## Update VPC ID from LocalStack (same as update-vpc)
	@$(MAKE) update-vpc

update-subnets-localstack: ## Update subnet IDs from LocalStack (same as update-subnets)
	@$(MAKE) update-subnets

s3_tf_state: ## Create S3 bucket for Terraform state in LocalStack if it doesn't exist
	@echo "📦 Checking S3 bucket for Terraform state..."
	@BUCKET_NAME=$$(grep -A 10 "## LocalStack configuration" backend.tf | grep "bucket" | grep -v "#" | sed 's/.*"\(.*\)".*/\1/' | head -1); \
	if [ -z "$$BUCKET_NAME" ]; then \
		BUCKET_NAME=$$(grep -A 5 "## AWS configuration" backend.tf | grep "bucket" | grep -v "#" | sed 's/.*"\(.*\)".*/\1/' | head -1); \
	fi; \
	if [ -z "$$BUCKET_NAME" ]; then \
		echo "❌ Error: Could not extract bucket name from backend.tf"; \
		exit 1; \
	fi; \
	echo "   Bucket name: $$BUCKET_NAME"; \
	if aws s3 ls s3://$$BUCKET_NAME --endpoint-url=$(LOCALSTACK_ENDPOINT) --profile $(LOCALSTACK_PROFILE) 2>/dev/null; then \
		echo "✅ S3 bucket '$$BUCKET_NAME' already exists."; \
	else \
		echo "   Creating S3 bucket '$$BUCKET_NAME'..."; \
		aws s3 mb s3://$$BUCKET_NAME --endpoint-url=$(LOCALSTACK_ENDPOINT) --profile $(LOCALSTACK_PROFILE); \
		if [ $$? -eq 0 ]; then \
			echo "✅ S3 bucket '$$BUCKET_NAME' created successfully."; \
		else \
			echo "❌ Error: Failed to create S3 bucket."; \
			exit 1; \
		fi; \
	fi

# Terraform commands
init: ## Initialize Terraform
	terraform init -reconfigure

plan: ## Run Terraform plan
	terraform plan -var-file="terraform.tfvars"

apply: ## Apply Terraform changes
	terraform apply -var-file="terraform.tfvars"

destroy: ## Destroy Terraform resources
	terraform destroy

fmt: ## Format Terraform files
	terraform fmt -recursive

validate: ## Validate Terraform files
	terraform validate
