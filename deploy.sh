#!/bin/bash
# Deploy script - applies Kubernetes manifests to cluster

echo "Deploying to Kubernetes..."

# Create kubeconfig file from secret (passed as env variable)
echo "$KUBECONFIG_B64" | base64 -d > kubeconfig

# Apply frontend deployment
echo "Deploying frontend..."
kubectl --kubeconfig kubeconfig apply -f kubernetes/deployment-frontend.yaml
kubectl --kubeconfig kubeconfig apply -f kubernetes/service-frontend.yaml

# Apply backend deployment
echo "Deploying backend..."
kubectl --kubeconfig kubeconfig apply -f kubernetes/deployment-backend.yaml
kubectl --kubeconfig kubeconfig apply -f kubernetes/service-backend.yaml

echo "done"

# Clean up kubeconfig
rm kubeconfig
