# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

 config.vm.provision "ansible" do |ansible|
    ansible.inventory_path = "ansible.ini"
    ansible.playbook = "provision.yml"
    ansible.verbose = "v"
  end  
  
  config.ssh.insert_key = false
  config.vm.box_check_update = false
  
  # disable guest additions
  config.vm.synced_folder ".", "/vagrant", id: "vagrant-root", disabled: true

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.customize ["modifyvm", :id, "--memory", 2024]
  end
  
  config.vm.define :centos6, autostart: true do |centos6_config|
    centos6_config.vm.box = "chef/centos-6.6"  # to delete: 'vagrant destroy; box remove chef/centos-6.6'
    centos6_config.vm.box_url = "https://atlas.hashicorp.com/chef/boxes/centos-6.6"
    centos6_config.vm.network "forwarded_port", id: 'ssh', guest: 22, host: 2201, auto_correct: true
    
    centos6_config.vm.provider "virtualbox" do |vb|
      vb.name = "centos6"
    end
  end
  
  config.vm.define :coreos, autostart: true do |coreos_config|
    coreos_config.vm.box = "coreos-box"  # to delete: 'vagrant destroy; box remove coreos-box'
    coreos_config.vm.box_url = "http://stable.release.core-os.net/amd64-usr/557.2.0/coreos_production_vagrant.box"
    coreos_config.vm.network "forwarded_port", id: 'ssh', guest: 22, host: 2200, auto_correct: true
    
    coreos_config.vm.provider "virtualbox" do |vb|
      vb.name = "coreos"
    end
  end
  
  config.vm.define :ubuntu14, autostart: true do |ubuntu14_config|
    ubuntu14_config.vm.box = "chef/ubuntu-14.04"  # to delete: 'vagrant destroy; box remove chef/ubuntu-14.04'
    ubuntu14_config.vm.box_url = "https://atlas.hashicorp.com/chef/boxes/ubuntu-14.04"
    ubuntu14_config.vm.network "forwarded_port", id: 'ssh', guest: 22, host: 2202, auto_correct: true
    
    ubuntu14_config.vm.provider "virtualbox" do |vb|
      vb.name = "ubuntu14"
    end
  end
end
