
resource "aws_efs_file_system" "main" {
  creation_token   = "chip-efs-shared"
  performance_mode = "generalPurpose"
}

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

resource "aws_efs_mount_target" "efs_mount_pods" {
  count = length(var.subnet_ids)

  file_system_id = aws_efs_file_system.main.id
  subnet_id      = var.subnet_ids[count.index]
  security_groups = [
    aws_security_group.efs.id
  ]
}

resource "kubectl_manifest" "efs_storage_class" {
  yaml_body = <<-YAML
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: chip-efs-shared
provisioner: efs.csi.aws.com
parameters:
  provisioningMode: efs-ap
  fileSystemId: ${aws_efs_file_system.main.id}
  directoryPerms: "777"
reclaimPolicy: Retain
volumeBindingMode: WaitForFirstConsumer
  YAML

  depends_on = [
    aws_efs_file_system.main,
    aws_efs_mount_target.efs_mount_pods
  ]
}

resource "kubectl_manifest" "efs_pvc" {
   yaml_body = <<-YAML
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: chip-efs-shared
  namespace: chip
spec:
  storageClassName: chip-efs-shared
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 10Gi
  YAML

  depends_on = [
    kubectl_manifest.efs_storage_class
  ] 
}