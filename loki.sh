#!/bin/bash

# Define variables
NAMESPACE="loki"
RELEASE_NAME="loki"
CHART_NAME="grafana/loki-stack"
LOKI_REPOSITORY="grafana/loki"
LOKI_TAG="2.9.3"

# Step 1: Add Helm repository (if not already added)
echo "Adding Helm repository..."
helm repo add grafana https://grafana.github.io/helm-charts

# Step 2: Update Helm repository
echo "Updating Helm repository..."
helm repo update

# Step 3: Install or upgrade Loki stack
echo "Installing or upgrading Loki stack..."
helm upgrade --install $RELEASE_NAME $CHART_NAME \
  --namespace=$NAMESPACE --create-namespace \
  --set loki.image.repository=$LOKI_REPOSITORY \
  --set loki.image.tag=$LOKI_TAG \
  --set fluent-bit.enabled=true \
  --set promtail.enabled=true

echo "Loki stack setup completed."
