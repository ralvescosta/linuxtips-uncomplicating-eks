resource "kubectl_manifest" "storage_class_gp3" {
  yaml_body = <<-YAML
    apiVersion: storage.k8s.io/v1
    kind: StorageClass
    metadata:
      name: gp3
    provisioner: ebs.csi.aws.com
    parameters:
      fsType: ext4
      type: gp3
    reclaimPolicy: Delete
    volumeBindingMode: WaitForFirstConsumer
    allowVolumeExpansion: true
  YAML
}