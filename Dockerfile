FROM ubuntu:14.04

RUN apt-get update
RUN apt-get -y install openssh-server

RUN useradd -p j8RjLtYv9yrgA -d /home/mapr -m -U mapr
RUN usermod -a -G sudo mapr
RUN su -l mapr -c 'ssh-keygen -q -N "" -t rsa -f $HOME/.ssh/id_rsa' 
RUN su -l mapr -c 'cp $HOME/.ssh/id_rsa.pub $HOME/.ssh/authorized_keys'

# java repo
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" > /etc/apt/sources.list.d/webupd8team-java.list
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections

# mapr repo
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A7B2E5DE
RUN echo "deb http://package.mapr.com/releases/v3.1.0/ubuntu/ mapr optional" >> /etc/apt/sources.list.d/maprtech.list
RUN echo "deb http://package.mapr.com/releases/ecosystem/ubuntu binary/" >> /etc/apt/sources.list.d/maprtech.list

# pull new package lists
RUN apt-get update
RUN apt-get -y install oracle-java7-installer
RUN apt-get -y --allow-unauthenticated install mapr-single-node

# explictly set JAVA_HOME
RUN sed -i 's|#export JAVA_HOME=|export JAVA_HOME=/usr/lib/jvm/java-7-oracle|g' /opt/mapr/conf/env.sh
