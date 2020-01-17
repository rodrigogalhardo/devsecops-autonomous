#!/bin/bash

kubectl create secret generic cert-grafana-prd \
  --from-literal=password=4109fd89-ad51-4cc2-a6e7-6081e781e0bd

# https://github.com/helm/charts/tree/master/stable/prometheus-operator

NAMESPACE="monitoring"
NAME="cluster-monitor"

# kubectl apply -f storage-class.yaml

helm install stable/prometheus-operator \
    --name $NAME \
    --namespace $NAMESPACE \
    -f custom-values.yaml
