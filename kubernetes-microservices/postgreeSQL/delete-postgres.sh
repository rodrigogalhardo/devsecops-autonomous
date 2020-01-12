# Created by:
# Rodrigo Galhardo | Arquiteto de soluções , DevSecOps Leader
# Vinicius Ribeiro | Arquiteto de Soluções , DevOps Engineer


# Attempt to run this script sequence, `cause you will drop all of your db microservice.`
kubectl delete service postgres 
kubectl delete deployment postgres
kubectl delete configmap postgres-config
kubectl delete persistentvolumeclaim postgres-pv-claim
kubectl delete persistentvolume postgres-pv-volume