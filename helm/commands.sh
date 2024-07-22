helm create first-chart
kubectl create namespace helm-ns 
helm install first-chart .\Helm\first-chart\ --namespace helm-ns

helm template first-chart .
helm upgrade first-chart . --namespace=helm-ns
kubectl describe cm mysql-configmap  --namespace=helm-ns

# switch to helm-ns namespace
kubectl config set-context --current --namespace=helm-ns

# copy secret to the helm template folder
helm upgrade first-chart .
kubectl describe secret  mysql-db-pass

helm history first-chart 

helm rollback first-chart

# to revert to specific version
helm rollback first-chart 1

# adding bitnami repo
helm repo add bitnami https://charts.bitnami.com/bitnami
# search for mysql
helm search repo mysql
# install mysql
helm install my-mysql bitnami/mysql
# list all the helm charts in the namespace
helm list --namespace helm-ns

helm status my-mysql --namespace helm-ns

kubectl edit secret my-mysql --namespace helm-ns