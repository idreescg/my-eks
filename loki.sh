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
  --set promtail.enabled=true \
  --set loki.config.limits_config.volume_enabled=true \
  --set loki.config.limits_config.allow_structured_metadata=true \
  --set loki.storage.type=s3 \
  --set loki.storage.s3.bucketnames=loki-logs-ahmed \
  --set loki.storage.s3.endpoint=s3.amazonaws.com \
  --set loki.schemaConfig.configs[0].from=2024-01-01 \
  --set loki.schemaConfig.configs[0].store=boltdb-shipper \
  --set loki.schemaConfig.configs[0].object_store=s3 \
  --set loki.schemaConfig.configs[0].schema=v12 \
  --set loki.schemaConfig.configs[0].index.prefix=index_ \
  --set loki.schemaConfig.configs[0].index.period=24h

echo "Loki stack setup completed."
