mapr-basenode
===============

A Dockerfile that installs the core MapR packages but does not initialize the cluster. It is intended to be a base image for specialized node containers. 

The Vagrantfile does the same thing, but it completes the initialization process.

### Non-Core Packages
The `non-core.sh` script includes commented lines for all the non-core packages included in the MapR sandbox. Uncomment to suit your needs.

* Hbase
* Hive (using HiverServer2)
* Oozie
* Pig
* Hue

### Vagrant Disk File Location
MapR wants a disk or partition to manage directly ([this video](https://www.youtube.com/watch?v=fP4HnvZmpZI) has a great discussion of the rationale). During provisioning Vagrant will create a .vdi file for this disk. You can change the location of the file using the `MAPR_DISK` variable in the Vagrantfile.

