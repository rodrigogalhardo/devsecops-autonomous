## Acessar dashboard Prometheus
kubectl --namespace monitoring port-forward svc/prometheus-operated 9090

## Acessar dashboard Grafana
kubectl --namespace monitoring port-forward svc/aks-monitor-grafana 3000:80 

## Acessar alertmanager
kubectl --namespace monitoring port-forward service/alertmanager-operated 5000:9093
