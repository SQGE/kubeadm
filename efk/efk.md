
ES

kubectl create -f kube-logging.yaml
kubectl create -f elasticsearch-storageclass.yaml
kubectl create -f elasticsearch-statefulset.yaml
kubectl create -f elasticsearch-svc.yaml
kubectl get sts -n logging



pods 部署完成后，我们可以通过请求一个 REST API 来检查 Elasticsearch 集群是否正常运行。使用下面的命令将本地端口9200转发到 Elasticsearch 节点（如es-cluster-0）对应的端口：
kubectl port-forward es-cluster-0 9200:9200 --namespace=logging
Forwarding from 127.0.0.1:9200 -> 9200
Forwarding from [::1]:9200 -> 9200

然后，在另外的终端窗口中，执行如下请求：
curl http://localhost:9200/_cluster/state?pretty






Kibana

kubectl create -f kibana.yaml

查看 Kibana Pod 的运行状态
kubectl get pods --namespace=logging


kubectl get svc --namespace=logging
浏览器中打开http://<任意节点IP>:33333






Fluentd


kubectl create -f fluentd-configmap.yaml
kubectl create -f fluentd-daemonset.yaml





test


kubectl create -f test-pod.yaml