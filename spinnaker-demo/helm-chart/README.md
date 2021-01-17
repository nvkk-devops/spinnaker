## Spinnaker install via helm-chart

- Helmchart (deprecated)
```
$ kubectl create ns helm-spinnaker

$ curl -Lo values.yaml https://raw.githubusercontent.com/kubernetes/charts/master/stable/spinnaker/values.yaml

$ helm install -n helm-spinnaker stable/spinnaker -f values.yaml --timeout 300  --version 1.19.4 --namespace helm-spinnaker 

```