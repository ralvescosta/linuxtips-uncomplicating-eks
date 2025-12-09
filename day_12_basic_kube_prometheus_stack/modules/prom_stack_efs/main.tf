resource "aws_security_group" "efs" {
  name   = "chip-efs-shared"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_efs_file_system" "prometheus" {
  creation_token   = format("%s-efs-prometheus", var.project_name)
  performance_mode = "generalPurpose"
}

resource "aws_efs_mount_target" "prometheus" {
  count = length(var.subnet_ids)

  file_system_id = aws_efs_file_system.prometheus.id
  subnet_id      = var.subnet_ids[count.index]
  security_groups = [
    aws_security_group.efs.id
  ]
}

resource "kubectl_manifest" "prometheus_sc" {
  yaml_body = <<-YAML
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: efs-prometheus
provisioner: efs.csi.aws.com
parameters:
  provisioningMode: efs-ap
  fileSystemId: ${aws_efs_file_system.prometheus.id}
  directoryPerms: "777"
reclaimPolicy: Retain
volumeBindingMode: WaitForFirstConsumer
  YAML

  depends_on = [
    aws_efs_file_system.main,
    aws_efs_mount_target.efs_mount_pods
  ]
}


resource "aws_efs_file_system" "grafana" {
  creation_token   = format("%s-efs-grafana", var.project_name)
  performance_mode = "generalPurpose"
}

resource "aws_efs_mount_target" "grafana" {
  count = length(var.subnet_ids)

  file_system_id = aws_efs_file_system.grafana.id
  subnet_id      = var.subnet_ids[count.index]
  security_groups = [
    aws_security_group.efs.id
  ]
}

resource "kubectl_manifest" "grafana_sc" {
  yaml_body = <<-YAML
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: efs-grafana
provisioner: efs.csi.aws.com
parameters:
  provisioningMode: efs-ap
  fileSystemId: ${aws_efs_file_system.grafana.id}
  directoryPerms: "777"
reclaimPolicy: Retain
volumeBindingMode: WaitForFirstConsumer
  YAML

  depends_on = [
    aws_efs_file_system.main,
    aws_efs_mount_target.efs_mount_pods
  ]
}
