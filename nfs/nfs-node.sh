#!/bin/bash

#安装配置 nfs
nfs='192.168.160.100'
mkdir -p  /data/k8s && chmod 755 /data/k8s/
yum -y install nfs-utils rpcbind
mount -t nfs $nfs:/data/k8s /data/k8s
grep "$nfs:/mnt /mnt            nfs     rw" /etc/fstab || echo "192.168.48.130:/mnt /mnt            nfs     rw" >> /etc/fstab 

systemctl start rpcbind.service 
systemctl enable rpcbind.service 
systemctl start nfs.service    
systemctl enable nfs.service
