 #安装配置 nfs
mkdir -p  /data/k8s && chmod 755 /data/k8s/
yum -y install nfs-utils rpcbind
grep "/data/k8s  *(rw,sync,no_root_squash)" /etc/exports || echo "/data/k8s  *(rw,sync,no_root_squash)" >> /etc/exports
systemctl start rpcbind.service && systemctl enable rpcbind && systemctl status rpcbind
#启动 nfs 服务
systemctl start nfs.service && systemctl enable nfs && systemctl status nfs
rpcinfo -p|grep nfs
cat /var/lib/nfs/etab