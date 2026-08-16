#!/bin/bash
# Deploy script - applies Kubernetes manifests to cluster

echo "Deploying to Kubernetes..."

# Create kubeconfig file from secret (passed as env variable)
echo "$KUBECONFIG_B64" | base64 -d > kubeconfig

echo "Kubernetes context:"
kubectl --kubeconfig kubeconfig config current-context

NAMESPACE=$(kubectl --kubeconfig kubeconfig config view --minify \
  --output 'jsonpath={..namespace}')

if [ -z "$NAMESPACE" ]; then
  NAMESPACE="default"
fi

echo "Kubernetes namespace: $NAMESPACE"

#Apply Database
kubectl --kubeconfig kubeconfig apply -f kubernetes/configmap.yaml
kubectl --kubeconfig kubeconfig apply -f kubernetes/persistant-volume.yaml
kubectl --kubeconfig kubeconfig apply -f kubernetes/deployment-redis.yaml
kubectl --kubeconfig kubeconfig apply -f kubernetes/service-redis.yaml

# Apply backend deployment
echo "Deploying backend..."
kubectl --kubeconfig kubeconfig apply -f kubernetes/deployment-backend.yaml
kubectl --kubeconfig kubeconfig apply -f kubernetes/service-backend.yaml

# Apply frontend deployment
echo "Deploying frontend..."
kubectl --kubeconfig kubeconfig apply -f kubernetes/deployment-frontend.yaml
kubectl --kubeconfig kubeconfig apply -f kubernetes/service-frontend.yaml
kubectl --kubeconfig kubeconfig apply -f kubernetes/ingress.yaml

kubectl --kubeconfig kubeconfig get pods -n "$NAMESPACE"
kubectl --kubeconfig kubeconfig get svc -n "$NAMESPACE"
kubectl --kubeconfig kubeconfig get ingress -n "$NAMESPACE"

echo "done"

# Clean up kubeconfig
rm kubeconfig
