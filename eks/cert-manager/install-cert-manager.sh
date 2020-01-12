#!/bin/bash
# https://github.com/jetstack/cert-manager/tree/master/deploy/charts/cert-manager
# https://docs.cert-manager.io/en/latest/getting-started/install/kubernetes.html 
# https://docs.cert-manager.io/en/latest/tasks/issuers/setup-acme/dns01/azuredns.html

# Install the CustomResourceDefinition resources separately
kubectl apply \
    -f https://raw.githubusercontent.com/jetstack/cert-manager/release-0.10/deploy/manifests/00-crds.yaml

# Create the namespace for cert-manager
kubectl create namespace cert-manager

# Label the cert-manager namespace to disable resource validation
kubectl label namespace cert-manager certmanager.k8s.io/disable-validation=true

# Add the Jetstack Helm repository
helm repo add jetstack https://charts.jetstack.io

# Update your local Helm chart repository cache
helm repo update

# Install the cert-manager Helm chart
helm install \
  --name cert-manager \
  --namespace cert-manager \
  --version v0.10.0 \
  jetstack/cert-manager
  
kubectl create namespace cert-manager

echo ${AWS_SECRET_ACCESS_KEY} > password.txt

kubectl create secret generic aws-route53-creds --from-file=password.txt -n cert-manager

#Aguardando certmanager subir
sleep 60

kubectl apply -f acme-dns-letsencrypt-prod.yaml

kubectl get secret cert-prod-wildcard -n cert-manager --export -o yaml | \
kubectl apply -n traefik -f -

# Create IAM permissions aws

cat << EOF > letsencrypt-wildcard.json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "route53:GetChange",
            "Resource": "arn:aws:route53:::change/*"
        },
        {
            "Effect": "Allow",
            "Action": "route53:ChangeResourceRecordSets",
            "Resource": "arn:aws:route53:::hostedzone/*"
        },
        {
            "Effect": "Allow",
            "Action": "route53:ListHostedZonesByName",
            "Resource": "*"
        }
    ]
}
EOF
aws iam create-policy --policy-name letsencrypt-wildcard --policy-document file://${PWD}/letsencrypt-wildcard.json

## GET THE ARN and add to acme-dns-lestencrypt-prod


# helm install \
#   --name cert-manager \
#   --namespace cert-manager \
#   --set ingressShim.defaultIssuerKind=ClusterIssuer \
#   --set ingressShim.defaultIssuerName=letsencrypt-prod \
#   --set extraArgs='{--dns01-recursive-nameservers-only,--dns01-self-check-nameservers=8.8.8.8:53}' \
#   jetstack/cert-manager

# helm upgrade cert-manager \
#     jetstack/cert-manager \
#   --reuse-values \
#   --set ingressShim.defaultIssuerKind=ClusterIssuer \
#   --set ingressShim.defaultIssuerName=letsencrypt-prod \
#   --set extraArgs='{--dns01-recursive-nameservers-only,--dns01-self-check-nameservers=8.8.8.8:53\,1.1.1.1:53}'

#   helm upgrade cert-manager \
#     jetstack/cert-manager \
#   --reuse-values \
#   --set ingressShim.defaultIssuerKind=ClusterIssuer \
#   --set ingressShim.defaultIssuerName=letsencrypt-prod \
#   --set extraArgs='{--dns01-recursive-nameservers-only,--dns01-self-check-nameservers=8.8.8.8:53}'
  