#!/bin/bash

#安装配置 nfs
nfs='192.168.160.100'
dir='/data/k8s'

mkdir -p  $dir && chmod 755 $dir
yum -y install nfs-utils rpcbind
mount -t nfs $nfs:$dir $dir
grep "$nfs:$dir $dir nfs rw" /etc/fstab || echo "$nfs:$dir $dir nfs rw" >> /etc/fstab 

systemctl start rpcbind.service 
systemctl enable rpcbind.service 
systemctl start nfs.service    
systemctl enable nfs.service
