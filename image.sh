set -e

##版本
VERSION=v1.13.1


echo ""
echo "=========================================================="
echo "Pull Kubernetes $VERSION Images from aliyuncs.com ......"
echo "=========================================================="
echo ""


##阿里云镜像仓库
MY_REGISTRY=registry.cn-hangzhou.aliyuncs.com/google_containers


## 拉取镜像
docker pull ${MY_REGISTRY}/kube-apiserver:$VERSION
docker pull ${MY_REGISTRY}/kube-controller-manager:$VERSION
docker pull ${MY_REGISTRY}/kube-scheduler:$VERSION
docker pull ${MY_REGISTRY}/kube-proxy:$VERSION
docker pull ${MY_REGISTRY}/pause:3.1
docker pull ${MY_REGISTRY}/etcd:3.2.24
docker pull ${MY_REGISTRY}/coredns:1.2.6


## 添加Tag
docker tag ${MY_REGISTRY}/kube-apiserver:$VERSION k8s.gcr.io/kube-apiserver:$VERSION
docker tag ${MY_REGISTRY}/kube-controller-manager:$VERSION k8s.gcr.io/kube-controller-manager:$VERSION
docker tag ${MY_REGISTRY}/kube-scheduler:$VERSION k8s.gcr.io/kube-scheduler:$VERSION
docker tag ${MY_REGISTRY}/kube-proxy:$VERSION k8s.gcr.io/kube-proxy:$VERSION
docker tag ${MY_REGISTRY}/pause:3.1 k8s.gcr.io/pause:3.1
docker tag ${MY_REGISTRY}/etcd:3.2.24 k8s.gcr.io/etcd:3.2.24
docker tag ${MY_REGISTRY}/coredns:1.2.6 k8s.gcr.io/coredns:1.2.6


echo ""
echo "=========================================================="
echo "Pull Kubernetes $VERSION Images FINISHED."
echo "into registry.cn-hangzhou.aliyuncs.com/google_containers "
echo "=========================================================="

