#!/bin/bash -eux

HOSTNAME=$(hostname)

apt-get -y update
apt-get -y upgrade

## install hbase and reconfig
# apt-get -y --allow-unauthenticated install mapr-hbase
# /opt/mapr/server/configure.sh -C $HOSTNAME -Z $HOSTNAME
# service mapr-zookeeper restart
# service mapr-warden restart

## hive with hiveserver2
# apt-get -y --allow-unauthenticated install mapr-hivemetastore mapr-hiveserver2

## oozie
# apt-get -y --allow-unauthenticated install mapr-oozie mapr-oozie-internal

## pig
# apt-get -y --allow-unauthenticated install mapr-pig

## hue
# apt-get -y --allow-unauthenticated install mapr-hue mapr-httpfs
