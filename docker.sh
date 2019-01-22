#!/bin/bash

yum install -y yum-utils device-mapper-persistent-data lvm2  
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo  
yum makecache fast  
yum install -y --setopt=obsoletes=0 docker-ce-18.06.1.ce-3.el7 

cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2",
  "storage-opts": [
    "overlay2.override_kernel_check=true"
  ]
}
EOF
  
systemctl start docker && systemctl enable docker
