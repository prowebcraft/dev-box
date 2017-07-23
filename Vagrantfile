# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

    config.vm.box = "scotch/box"
    config.vm.network "private_network", ip: "192.168.33.10"
    config.vm.hostname = "scotchbox"

    #Mac Version
    #config.vm.synced_folder "../Projects", "/var/www", :mount_options => ["dmode=777", "fmode=666"]
    
    #Win Version
    config.vm.synced_folder "../Projects", "/var/www", :nfs => { :mount_options => ["dmode=777","fmode=666"] }

    #Run extra provisioning script
    config.vm.provision "shell", path: "vm.provision.sh"
    
    #Forward port for xDebug
    config.vm.network "forwarded_port", guest: 8999, host: 8999
end
