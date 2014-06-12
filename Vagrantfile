# -*- mode: ruby -*-
# vi: set ft=ruby :

MAPR_DISK = './mapr.vdi'
IPADDR = '192.168.56.201'
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

	## To use a proxy, install vagrant-proxyconf and uncomment below
	# config.proxy.http     = "http://proxy.example.com:8080"
	# config.proxy.https    = "http://proxy.example.com:8080"
	# config.proxy.no_proxy = "localhost,127.0.0.1"

	config.vm.box = "ubuntu/trusty64"
	config.vm.hostname = "mapr-singlenode"
	config.vm.network "private_network", ip: IPADDR
	config.vm.network "forwarded_port", guest: 8443, host: 8443
	config.vm.provision "shell", path: "mapr-singlenode.sh", args: IPADDR
	config.vm.provider "virtualbox" do |v|
		v.name = "mapr-singlenode"
		v.customize ['modifyvm', :id, '--ioapic', 'on']
		v.customize ['modifyvm', :id, '--cpus', 2]
		v.customize ['modifyvm', :id, '--memory', 6860]
		unless File.exists? MAPR_DISK
			v.customize ['createhd', '--filename', MAPR_DISK, '--size', 100 * 1024]
        end
        v.customize ['storageattach', :id, '--storagectl', 'SATAController', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', MAPR_DISK]
	end

end
