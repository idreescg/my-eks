#!/bin/bash

# Download the required files
wget https://raw.githubusercontent.com/idreescg/my-eks/refs/heads/main/PrometheusAutomation.sh
wget https://raw.githubusercontent.com/idreescg/my-eks/refs/heads/main/aws-controller.sh
wget https://raw.githubusercontent.com/idreescg/my-eks/refs/heads/main/loki-values.yaml
wget https://raw.githubusercontent.com/idreescg/my-eks/refs/heads/main/promtail-values.yaml

# Make scripts executable
chmod +x aws-controller.sh PrometheusAutomation.sh

# Run the aws-controller script
sh aws-controller.sh
# Wait for 30 seconds
sleep 30

# Run the Prometheus automation script
sh PrometheusAutomation.sh
