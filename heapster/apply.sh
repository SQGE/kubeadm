
kubectl taint nodes --all node-role.kubernetes.io/master-
kubectl apply -f . 
kubectl apply -f rbac/heapster-rbac.yaml
