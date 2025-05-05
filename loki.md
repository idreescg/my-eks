# Loki Configuration

## Steps to Configure Loki

1. **Configure Datasource URL:**
    ```bash
    http://loki-gateway.loki.svc.cluster.local/loki
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
