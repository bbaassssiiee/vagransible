# vagransible
Ansible + Vagrant = vagransible


Vagransible is a demo presented by Bas Meijer in the Ansible-Benelux Meetup. 

<http://www.meetup.com/Ansible-Benelux/>

NOTE: This demo was made on a Mac where I have this in ~/.ansible.cfg

    [defaults]
    private_key_file=/Users/bassie/.ssh/vagrant.rsa
    host_key_checking=False
    ansible_managed = Ansible managed: %Y-%m-%d %H:%M:%S by {uid}

___
Vagrant allows users to create disposable virtual machines for their projects. These machines can be provisioned by Ansible. Combining both tools yields full control over development environments.
___
This project has a Makefile that wraps some longer commands and their dependencies. 

The Vagrantfile defines several virtual machines running a variety of operating systems:
    
    vagrant up centos6
    vagrant up fedora21  
    vagrant up ubuntu14  
    vagrant up coreos    
    vagrant up rancheros 

The provision.yml playbook defines what is done during the first run of the VM's. As an example the role geerlingguy.java installs Java as defined in the group_vars.

Centos 6 can be used in your first exploration of this demo.
Enter these commands with vagransible as the work directory:

    'make install' # download the required roles (like <https://galaxy.ansible.com/list#/roles/439>)

    'make centos' # download a pre-made box with Centos6 tp run in VirtualBox.

___
Testing the provisioning of a fresh virtual machine for presence of Java:

    make test
    

To show how security can be improved with Ansible:

    make stig 
    
    
To explore the management of Docker hosts:

    make docker
    
---
