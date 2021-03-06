# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.provision "ansible" do |ansible|
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
    if Vagrant.has_plugin?("vagrant-vbguest")
    config.vbguest.auto_update = false
  end
  config.vm.box_check_update = false
  # guest additions
  config.vm.synced_folder ".", "/vagrant", id: "vagrant-root"

  config.vm.define :centos6, autostart: true do |centos6_config|
    centos6_config.vm.box = "centos6"
    centos6_config.vm.hostname = "centos6"
    centos6_config.vm.network "forwarded_port", id: 'ssh', guest: 22, host: 2201, auto_correct: true
    centos6_config.vm.synced_folder ".", "/vagrant", id: "vagrant-root", disabled: true
    centos6_config.vm.provider "virtualbox" do |vb|
      vb.name = "centos6"
    end
  end
end
