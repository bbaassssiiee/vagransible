# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  config.vm.provision "ansible" do |ansible|
    ansible.inventory_path = "ansible.ini"
    ansible.playbook = "provision.yml"
    ansible.verbose = "vv"
   end  
  
  # Prefer VirtualBox before VMware Fusion  
  config.vm.provider "virtualbox"
  config.vm.provider "vmware_fusion"
  
  config.vm.provider "virtualbox" do |virtualbox|
    virtualbox.gui = false
    virtualbox.customize ["modifyvm", :id, "--memory", 2048]
  end

  config.ssh.insert_key = false
  config.vm.box_check_update = false
  # disable guest additions
  config.vm.synced_folder ".", "/vagrant", id: "vagrant-root", disabled: true

  config.vm.define :centos6, autostart: true do |centos6_config|
    centos6_config.vm.box = "dockpack/centos6"  # to delete: 'vagrant destroy; box remove chef/centos-6.6'
    centos6_config.vm.box_url = "https://atlas.hashicorp.com/dockpack/boxes/centos6"
    centos6_config.vm.network "forwarded_port", id: 'ssh', guest: 22, host: 2201, auto_correct: true

    centos6_config.vm.provider "virtualbox" do |vb|
      vb.name = "centos6"
    end
  end

  config.vm.define :fedora21, autostart: true do |fedora21_config|
    fedora21_config.vm.box = "chef/fedora-21"  # to delete: 'vagrant destroy; box remove chef/fedora-21'
    fedora21_config.vm.box_url = "https://atlas.hashicorp.com/chef/boxes/fedora-21"
    fedora21_config.vm.network "forwarded_port", id: 'ssh', guest: 22, host: 2204, auto_correct: true
    
    fedora21_config.vm.provider "virtualbox" do |vb|
      vb.name = "fedora21"
    end
  end

  config.vm.define :ubuntu14, autostart: true do |ubuntu14_config|
    ubuntu14_config.vm.box = "chef/ubuntu-14.04"  # to delete: 'vagrant destroy; box remove chef/ubuntu-14.04'
    ubuntu14_config.vm.box_url = "https://atlas.hashicorp.com/chef/boxes/ubuntu-14.04"
    ubuntu14_config.vm.network "forwarded_port", id: 'ssh', guest: 22, host: 2202, auto_correct: true
    
    ubuntu14_config.vm.provider "virtualbox" do |virtualbox|
      virtualbox.name = "ubuntu14"
    end
  end

  config.vm.define :coreos, autostart: true do |coreos_config|
    coreos_config.vm.box = "coreos-box"  # to delete: 'vagrant destroy; box remove coreos-box'
    
    coreos_config.vm.network "forwarded_port", id: 'ssh', guest: 22, host: 2200, auto_correct: true
    coreos_config.vm.provider "vmware_fusion" do |vmware, override|
      override.vm.box_url = "http://stable.release.core-os.net/amd64-usr/557.2.0/coreos_production_vagrant_vmware_fusion.box"
    end
    coreos_config.vm.provider "virtualbox" do |virtualbox, override|
      override.vm.box_url = "http://stable.release.core-os.net/amd64-usr/557.2.0/coreos_production_vagrant.box"
      virtualbox.name = "coreos"
    end
  end
  
  config.vm.define :rancheros, autostart: true do |rancheros_config|
    rancheros_config.vm.box  = "rancheros"
    
    rancheros_config.vm.network "forwarded_port", id: 'ssh', guest: 22, host: 2203, auto_correct: true
    rancheros_config.ssh.username = "rancher"
  
    rancheros_config.vm.provider "virtualbox" do |virtualbox, override|
      override.vm.box_url = "http://cdn.rancher.io/vagrant/x86_64/prod/rancheros_virtualbox.box"  
      virtualbox.name = "rancheros"
    end
  end
end
