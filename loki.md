# Loki Configuration

## Steps to Configure Loki

1. **Configure Datasource URL:**
    ```bash
    http://loki-gateway.loki.svc.cluster.local/loki
    ```
    or 
    ```bash
    http://loki-gateway.loki.svc.cluster.local
    ```

2. **Set Header Key and Value:**
    ```bash
    X-Scope-OrgID
    ```
    
    ```bash
    default
    ```

3. **Add Inline Policy to LokiServiceAccountRole:**
    ```json
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Sid": "LokiStorage",
                "Effect": "Allow",
                "Action": [
                    "s3:ListBucket",
                    "s3:PutObject",
                    "s3:GetObject",
                    "s3:DeleteObject"
                ],
                "Resource": [
                    "arn:aws:s3:::loki-ahmed-1",
                    "arn:aws:s3:::loki-ahmed-1/*",
                    "arn:aws:s3:::loki-ahmed-2",
                    "arn:aws:s3:::loki-ahmed-2/*"
                ]
            }
        ]
    }
    ```

4. **Add Trust Policy:**
    ```bash
    "oidc.eks.<INSERT REGION>.amazonaws.com/id/<OIDC ID>:sub": "system:serviceaccount:loki:loki"
    ```
5. **To Run loki:**
   ```bash
   helm repo add grafana https://grafana.github.io/helm-charts
   ```
   ```bash
   helm repo update
   ```
   ```bash
   helm upgrade --install loki grafana/loki --namespace loki --create-namespace -f loki-values.yaml
   ```
6. **To Run promtail in loki namespace:**
   ```bash
   helm upgrade --install promtail grafana/promtail --namespace loki --create-namespace -f promtail-values.yaml
   ```
   
