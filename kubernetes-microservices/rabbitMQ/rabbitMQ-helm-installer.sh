#!/bin/bash

helm upgrade

kubectl create namespace rabbit

kubectl create secret generic rabbitmq-config --from-literal=cardpay-rabbit

helm install --set persistence.existingClaim=CARDPAY_RABBIT_PVC rabbitmq

helm install --name cardpay-rabbit \
    --set rabbitmq.username=admin,rabbitmq.password=cardpay
    --set rabbitmq.erlangCookie=rabbitmq-config
    --namespace rabbit \
    -f values-production.yaml \
    stable/rabbitmq

echo "Aguardando  a criaçao do rabittoo :)"

watch kubectl get deployments,pods,services --namespace rabbit


#kubectl describe service rabbitmq-management

