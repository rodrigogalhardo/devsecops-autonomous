#!/bin/bash

clear

export AWS_ACCESS_KEY_ID=AKIAYGK2HOIZXVM6GOF4
export AWS_SECRET_ACCESS_KEY=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

cat <<EOF ~/.aws/config
[default]
output = json
region = us-west-2
EOF

cat <<EOF ~/.aws/credentials
[default]
aws_access_key_id = AKIAYGK2HOIZXVM6GOF4
aws_secret_access_key = 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
EOF

aws eks update-kubeconfig --name SRVAWSEKSCl01 --region=us-west-2

echo -e "Variable defined"

echo -e "\nGetting cluster"

kubectl get all --all-namespaces