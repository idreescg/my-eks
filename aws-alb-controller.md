# AWS Load Balancer Controller Setup

## Steps to install the ALB Controller into the EKS

1. **Associate IAM OIDC Provider:**
    ```bash
    eksctl utils associate-iam-oidc-provider --region=us-east-1 --cluster=demo-cluster --approve
    ```

2. **Download IAM Policy:**
    ```bash
    curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.11.0/docs/install/iam_policy.json
    ```

3. **Create IAM Policy:**
    ```bash
    aws iam create-policy \
        --policy-name AWSLoadBalancerControllerIAMPolicy \
        --policy-document file://iam_policy.json
    ```

4. **Create IAM Service Account:**
    ```bash
    eksctl create iamserviceaccount \
      --cluster=demo-cluster \
      --namespace=kube-system \
      --name=aws-load-balancer-controller \
      --role-name AmazonEKSLoadBalancerControllerRole \
      --attach-policy-arn=arn:aws:iam::account:policy/AWSLoadBalancerControllerIAMPolicy \
      --approve
    ```

5. **Add Helm Repository:**
    ```bash
    helm repo add eks https://aws.github.io/eks-charts
    ```

6. **Update Helm Repository:**
    ```bash
    helm repo update eks
    ```

7. **Install AWS Load Balancer Controller:**
    ```bash
    helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system \
      --set clusterName=demo-cluster \
      --set serviceAccount.create=false \
      --set serviceAccount.name=aws-load-balancer-controller \
      --set region=us-east-1 \
      --set vpcId=
    ```

8. **Verify Deployment:**
    ```bash
    kubectl get deployment -n kube-system aws-load-balancer-controller
    ```

