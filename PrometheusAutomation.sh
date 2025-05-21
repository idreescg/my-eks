#!/bin/bash

# Step 1: Add Helm Repository
echo "Adding Helm repository..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

# Step 2: Update Helm Repository
echo "Updating Helm repository..."
helm repo update

# Step 3: Install Prometheus
echo "Installing Prometheus..."
helm install prometheus prometheus-community/kube-prometheus-stack   --namespace monitoring   --create-namespace   --set prometheus.prometheusSpec.maximumStartupDurationSeconds=300
##helm install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace

# Step 4: Retrieve Password for Grafana
echo "Retrieving Grafana admin password..."
GRAFANA_PASSWORD=$(kubectl get secret -n monitoring prometheus-grafana -o jsonpath="{.data.admin-password}" | base64 --decode)
echo "Grafana admin password: $GRAFANA_PASSWORD"

# Apply Prometheus and Grafana Ingress configurations
echo "Applying Prometheus and Grafana Ingress configurations..."
kubectl apply -f https://raw.githubusercontent.com/idreescg/my-eks/refs/heads/main/prometheus-ingress.yaml
kubectl apply -f https://raw.githubusercontent.com/idreescg/my-eks/refs/heads/main/grafana-ingress.yaml

echo "Prometheus Stack setup completed. Please check the ALB DNS"
