resource "kubectl_manifest" "grafana" {
  yaml_body = <<YAML
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: grafana-ingress
  namespace: prometheus
  annotations:
spec:
  ingressClassName: nginx
  rules:
    - host: ${var.host}
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: prometheus-grafana
                port:
                  number: 80
YAML
  depends_on = [
    helm_release.nginx_controller
  ]
}