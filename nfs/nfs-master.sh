#!/bin/bash

dir='/data/k8s/'
#安装配置 nfs
mkdir -p $dir && chmod 755 $dir
yum -y install nfs-utils rpcbind
grep "$dir *(rw,sync,no_root_squash)" /etc/exports || echo "$dir  *(rw,sync,no_root_squash)" >> /etc/exports


#启动 nfs 服务
systemctl start rpcbind.service 
systemctl enable rpcbind 
systemctl status rpcbind

systemctl start nfs.service 
systemctl enable nfs 
systemctl status nfs

#检查nfs是否正常
rpcinfo -p|grep nfs
cat /var/lib/nfs/etab
