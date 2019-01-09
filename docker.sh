#!/bin/bash

yum install -y yum-utils device-mapper-persistent-data lvm2  
yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo  
yum makecache fast  
yum install -y --setopt=obsoletes=0 docker-ce-18.06.1.ce-3.el7 
  
systemctl start docker && systemctl enable docker