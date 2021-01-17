# Spinnaker

## Installation Options
- Kubernetes Operator
- Halyard
- Helmchart
- [Kustomize](https://kustomize.io/)

## Start/Stop Minikube
```
$ minikube start --vm-driver=virtualbox --memory 9126
# --cpus 4 

$ minikube stop
```

## Kubernetes Operator
- Create secrets/configmap (preferred secrets) 'aws-secrets-map' inside the target namespace where kube-operator is installed
```
apiVersion: v1
data:
  AWS_ACCESS_KEY_ID: ************
  AWS_SECRET_ACCESS_KEY: ************
  AWS_DEFAULT_REGION: ************
kind: ConfigMap
metadata:
  name: aws-secrets-map
```

- Install 'kube-operator'. Refer [operator-deploy](kube-operator/deploy/operator) resources.
```
VERSION=v1.2.2

# Install or update CRDs cluster wide
$ kubectl apply -f kube-operator/deploy/crds/

# Install operator in namespace spinnaker-operator, see below if you want a different namespace
$ kubectl create ns spinnaker-operator
$ kubectl -n spinnaker-operator apply -f kube-operator/deploy/operator/cluster

```
- Setting up the Service Account. Install [spinnaker-tools](https://docs.armory.io/docs/armory-admin/kubernetes-account-add/)
```
$(optional) curl -L https://github.com/armory/spinnaker-tools/releases/download/0.0.3/spinnaker-tools-darwin -o spinnaker-tools
$(optional) chmod +x spinnaker-tools

$ . ./kube-operator/deploy/spinnaker/basic/setenv.sh
$ ./kube-operator/deploy/spinnaker/basic/spinnaker-tools create-service-account \
  --kubeconfig ${SOURCE_KUBECONFIG} \
  --context ${CONTEXT} \
  --output ${DEST_KUBECONFIG} \
  --namespace ${SPINNAKER_NAMESPACE} \
  --service-account-name ${SPINNAKER_SERVICE_ACCOUNT_NAME}

```
- Install 'spinnaker'. Refer [spinnaker-deploy](kube-operator/deploy/spinnaker) resources.
```
# Update deploy/spinnaker/basic/spinnakerservice.yml to change Spinnaker's persistence bucket name to a unique name (persistentStorage.s3.bucket value)

# Install Spinnaker in "spinnaker" namespace
$ kubectl create ns spinnaker
$ kubectl -n spinnaker apply -f kube-operator/deploy/spinnaker/basic

# (Optional) if crashloop observed on spin-front50 deployment,
$ kubectl -n spinnaker apply -f spin-front50-deploy.yaml

# Watch the install progress, check out the pods being created too!
$ kubectl -n spinnaker get spinsvc spinnaker -w

$ kubectl port-forward deployment/spin-deck -n spinnaker 9000:9000
$ kubectl port-forward deployment/spin-deck -n spinnaker 9000:9000
```

- Note: Identify [release-version](https://github.com/armory/spinnaker-operator/releases)
