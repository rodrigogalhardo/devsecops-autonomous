# Created by:
# Rodrigo Galhardo | Arquiteto de soluções , DevSecOps Leader
# Vinicius Ribeiro | Arquiteto de Soluções , DevOps Engineer

#Prerequisites

#Working Kubernetes Cluster

#To Deploy PostgreSQL on Kubernetes we need to follow below steps:

#Postgres Docker Image
#Config Maps for storing Postgres configurations
#Persistent Storage Volume
#PostgreSQL Deployment
#PostgreSQL Service

echo "Running Postgres SQL bash Installer <--->"


echo "executing > Config Maps for storing Postgres configurations..."
kubectl create -f postgres-configmap.yaml 
#output: configmap "postgres-config" created
sleep 5

echo "executing > Persistent Storage Volume"
kubectl create -f postgres-storage.yaml 
#output: persistentvolume "postgres-pv-volume" created
#output: persistentvolumeclaim "postgres-pv-claim" created

sleep 5

echo "PostgreSQL Deployment"
kubectl create -f postgres-deployment.yaml 
#output: deployment "postgres" created

sleep 5

echo "PostgreSQL Service"
kubectl create -f postgres-service.yaml 
#output: service "postgres" created

echo "Waiting 60s or more to finish installation of."
sleep 60

echo "Testing deployment > Decribing..."
kubectl get svc postgres

echo "Outras formas de instalar o PostgreSQL com StatefulSets e HPA"
echo "See into: https://kubernetes.io/blog/2017/02/postgresql-clusters-kubernetes-statefulsets/"
