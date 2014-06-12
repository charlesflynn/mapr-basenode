#!/bin/bash -eux

# just to be sure we can keygen...
apt-get -y install openssh-server

# mapr user
useradd -p j8RjLtYv9yrgA -d /home/mapr -m -U mapr
usermod -a -G sudo mapr
su -l mapr -c 'ssh-keygen -q -N "" -t rsa -f $HOME/.ssh/id_rsa' 
su -l mapr -c 'cp $HOME/.ssh/id_rsa.pub $HOME/.ssh/authorized_keys'

# java repo
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" > /etc/apt/sources.list.d/webupd8team-java.list
echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections

# mapr repo
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A7B2E5DE
echo "deb http://package.mapr.com/releases/v3.1.0/ubuntu/ mapr optional" >> /etc/apt/sources.list.d/maprtech.list
echo "deb http://package.mapr.com/releases/ecosystem/ubuntu binary/" >> /etc/apt/sources.list.d/maprtech.list

# docker repo
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
echo "deb https://get.docker.io/ubuntu docker main" > /etc/apt/sources.list.d/docker.list

# pull new package lists
apt-get update

# install everything
apt-get -y install oracle-java7-installer lxc-docker
apt-get -y --allow-unauthenticated install mapr-single-node

# explictly set JAVA_HOME
sed -i 's|#export JAVA_HOME=|export JAVA_HOME=/usr/lib/jvm/java-7-oracle|g' /opt/mapr/conf/env.sh

# uncomment pam session limits
sed -r -i 's|^#\s*session\s+required\s+pam_limits.so|session    required   pam_limits.so|g' /etc/pam.d/su

# configure the cluster
/opt/mapr/server/configure.sh -C $1 -Z $1 -D /dev/sdb
service mapr-zookeeper stop
service mapr-zookeeper start
service mapr-warden stop
service mapr-warden start

# time to get a license
echo "Basic installation completed."
echo "Access https://${1}:8443 and login with mapr/mapr"