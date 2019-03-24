# vagransible

Ansible + Vagrant = vagransible

Vagransible is a demo for HUG Amsterdam by Bas Meijer.
Check Presentation.pdf for the slides.

NOTE: This demo was made on a Mac.

Centos 6 is used in this exploration of Vagrant, Packer and Ansible.

## Usage

### Enter these commands with vagransible as the work directory

    'make prepare' # download the required roles
    'make demo'    # create a centos6 base image for virtualbox

___

- Vagrant allows users to create disposable virtual machines for their projects.
- Packer creates base images, for Vagrant and also for the clouds.
- Ansible provisions these machines.
- Combining these tools yields full control over development environments.

___
### make

This project has a Makefile that wraps some longer commands and their dependencies.

    make prepare    # install dependencies
    make packer     # build the centos image with packer
    make box        # add the packer built box for use by vagrant
    make up         # vagrant up, in an idempotent way
    make harden     # run the hardening

___
### Ansible

The packer.yml playbook defines what is done during the Packer run

The provision.yml playbook defines what is done during the Vagrant run.
___
**Hardening**

To show how security can be improved with Ansible:

    'make harden'  # run the RHEL6-STIG role to create a USG compliant VM

    'make audit'   # check if the VM is indeed compliant

The Vagrantfile defines a virtual machine with Centos 6, you can login to it:

    vagrant ssh

___
[@bbaassssiiee](https://twitter.com/bbaassssiiee)
___
