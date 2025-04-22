# Prometheus Setup

## Steps to Install Prometheus

1. **Add Helm Repository:**
    ```bash
    helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
    ```

2. **Update Helm Repository:**
    ```bash
    helm repo update
    ```

3. **Install Prometheus:**
    ```bash
    helm install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring --create-namespace
    ```
