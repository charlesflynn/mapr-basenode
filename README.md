mapr-singlenode
===============

This is a quick Vagrantfile to create a single-node MapR environment.

### Disk File Location
MapR wants a disk or partition to manage directly ([this video](https://www.youtube.com/watch?v=fP4HnvZmpZI) has a great discussion of the rationale). During provisioning Vagrant will create a .vdi file for this disk. You can change the location of the file using the `MAPR_DISK` variable in the Vagrantfile.

### Docker
The provisioning script installs Docker for my own purposes, but this is not needed for MapR. Feel free to remove those lines.

### Non-Core Packages
The `non-core.sh` script includes commented lines for all the non-core packages included in the MapR sandbox. Uncomment to suit your needs.

* Hbase
* Hive (using HiverServer2)
* Oozie
* Pig
* Hue

