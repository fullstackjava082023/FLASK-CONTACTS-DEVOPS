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


############# installing bitnami/kube-state-metrics
# create a namespace metrics
kubectl create namespace metrics
# add bitnami repo
helm repo add bitnami https://charts.bitnami.com/bitnami
# search for kube-state-metrics
helm search repo kube-state-metrics
# install kube-state-metrics
helm install my-kube-state-metrics bitnami/kube-state-metrics --version 4.2.9 -n metrics
# list all the helm charts in the namespace
helm ls -n metrics
# switch to metrics namespace
kubectl config set-context --current --namespace=metrics
# get the status of the helm chart
helm status my-kube-state-metrics
# see all objects whihc are created
kubectl get all 
# get the logs of the pod
kubectl logs <name of the pod>
# port forward the service on port 8091
kubectl port-forward svc/my-kube-state-metrics 8091:8080
# access the metrics on http://localhost:8091/metrics

# To see all yamls created we can run:
helm get manifest my-kube-state-metrics

# helm show command
# available options are all, values, values.schema, chart, readme..
# show chart information (high level)
helm show chart bitnami/kube-state-metrics

# to see the values (configuration) of the chart
helm show values bitnami/kube-state-metrics > values.yaml

# to see the charts on current namespace:
helm ls --n=metrics 

# Let's say i want to downgrade to the version of the app bitname/kube-state-metrics to the version 0.4.0
helm upgrade my-kube-state-metrics bitnami/kube-state-metrics --version 0.4.0 

#list all version of the chart in repo bitnami/kube-state-metrics
helm search repo bitnami/kube-state-metrics --versions

# delete the helm chart
helm delete my-kube-state-metrics --namespace metrics

# delete the namespace
kubectl delete namespace metrics

# switch to default namespace
kubectl config set-context --current --namespace=default


############## creation of own helm chart
# create a new folder my-helm
mkdir my-helm
cd my-helm
# create a namespace my-helm
kubectl create namespace my-helm
# switch to my-helm namespace
kubectl config set-context --current --namespace=my-helm
###
# create a new helm chart
helm create my-helm-chart


# install the helm chart
helm install my-helm-chart . 

# go to helm directory
cd .\my-helm\my-helm-chart\

# install the chart
helm install first-chart .

# see that configmap is created
kubectl get cm

# describe the configmap
kubectl describe cm first-chart-configmap

# see the template of the chart
helm template first-chart .

# apply the change to the cluster
helm upgrade first-chart .

# describe the configmap
kubectl describe cm first-chart-configmap

# check helm history
helm history first-chart

# rollback to previous version
helm rollback first-chart 

# upgrade the chart
helm upgrade first-chart .

# see the cm
kubectl get cm