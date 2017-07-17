# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define "admin_serer" do |server|
    server.vm.box = "centos/7"
    server.vm.network "private_network", ip: "192.168.33.110"
    server.vm.synced_folder "src", "/home/vagrant/src", type: "rsync"
    
    server.vm.provision "shell", :path => "provision.sh", privileged: false
  end

  config.vm.define "web_serer" do |server|
    server.vm.box = "centos/6"
    server.vm.network "private_network", ip: "192.168.33.20"
    server.vm.synced_folder "src", "/home/vagrant/src", type: "rsync"
    
    server.vm.provision "shell", :path => "provision_web.sh", privileged: false
    
    
    
  end
end

