# https://docs.armory.io/docs/armory-admin/kubernetes-account-add/

# If you're using a different source kubeconfig, specify it here
export SOURCE_KUBECONFIG=${HOME}/.kube/config

# Specify the name of the kubernetes context that has permissions in your target cluster.
# To get context names, you can run "kubectl config get-contexts".
export CONTEXT="minikube" #"aws-armory-dev"

# Enter the namespace where you want the Spinnaker service account to live
export SPINNAKER_NAMESPACE="spinnaker" #"spinnaker-system"

# Enter the name of the service account you want to create in the target namespace.
# If you are creating multiple Kubernetes Cloud Provider Accounts to point to
# different namespaces in to the same Kubernetes cluster, make sure you use a
# unique service account name.
export SPINNAKER_SERVICE_ACCOUNT_NAME="spinnaker-dev-sa"

# Specify where you want the new kubeconfig to be created
export DEST_KUBECONFIG=${PWD}/kubeconfig-dev-sa

# If you want to deploy to a specific set of namespaces, enter the namespaces
# that you want to deploy to (space-delimited).
# These namespaces can already exist, or you can create them.
export TARGET_NAMESPACES_COMMA_SEPARATED=code-challenge,test-autoscaling
