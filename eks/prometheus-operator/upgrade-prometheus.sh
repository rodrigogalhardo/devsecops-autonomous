# PRD

helm upgrade cluster-monitor stable/prometheus-operator --reuse-values -f custom-values.yaml


# helm upgrade stable/prometheus-operator \
#     --name cluster-monitor \
#     --namespace monitoring \
#     --reuse-values -f custom-values.yaml


