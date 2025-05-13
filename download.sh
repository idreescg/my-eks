wget  https://raw.githubusercontent.com/idreescg/my-eks/refs/heads/main/PrometheusAutomation.sh

wget https://raw.githubusercontent.com/idreescg/my-eks/refs/heads/main/aws-controller.sh

wget https://raw.githubusercontent.com/idreescg/my-eks/refs/heads/main/loki-values.yaml

wget https://raw.githubusercontent.com/idreescg/my-eks/refs/heads/main/promtail-values.yaml


run the below command 

sh aws-controller.sh

sleep 30

sh PrometheusAutomation.sh
