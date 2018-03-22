# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

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

  config.vbguest.auto_update = false
  config.ssh.insert_key = false
  config.vm.box_check_update = false
  # disable guest additions
  config.vm.synced_folder ".", "/vagrant", id: "vagrant-root", disabled: true

  config.vm.define :centos6, autostart: true do |centos6_config|
    centos6_config.vm.box = "centos/6"
    centos6_config.vm.network "forwarded_port", id: 'ssh', guest: 22, host: 2201, auto_correct: true

    centos6_config.vm.provider "virtualbox" do |vb|
      vb.name = "centos6"
    end
  end
end
