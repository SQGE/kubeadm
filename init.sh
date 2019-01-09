#!/bin/bash
set -e

yum install -y epel-release
yum install -y conntrack ipvsadm ipset jq sysstat curl iptables libseccomp
systemctl stop firewalld
systemctl disable firewalld
iptables -F && sudo iptables -X && sudo iptables -F -t nat && sudo iptables -X -t nat
iptables -P FORWARD ACCEPT
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
sudo setenforce 0
grep SELINUX /etc/selinux/config 

cat > kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

mv kubernetes.conf  /etc/sysctl.d/kubernetes.conf
modprobe br_netfilter
sysctl -p /etc/sysctl.d/kubernetes.conf

#加载内核模块
modprobe ip_vs

#加载ipvs模块
cat << EOF > /etc/sysconfig/modules/ipvs.modules 
#!/bin/bash
ipvs_modules_dir="/usr/lib/modules/\`uname -r\`/kernel/net/netfilter/ipvs"
for i in \`ls \$ipvs_modules_dir | sed  -r 's#(.*).ko.*#\1#'\`; do
    /sbin/modinfo -F filename \$i  &> /dev/null
    if [ \$? -eq 0 ]; then
        /sbin/modprobe \$i
    fi
done
EOF

chmod +x /etc/sysconfig/modules/ipvs.modules 
bash /etc/sysconfig/modules/ipvs.modules

