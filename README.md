# vagransible
Ansible + Vagrant = vagransible


Vagransible is a demo for HUG Amsterdam by Bas Meijer.
Check Presentation.pdf for the slides.

NOTE: This demo was made on a Mac.

___
Vagrant allows users to create disposable virtual machines for their projects. These machines can be provisioned by Ansible. Combining both tools yields full control over development environments. With Packer you can create base images, for Vagrant and also for the clouds.
___
This project has a Makefile that wraps some longer commands and their dependencies.

    make prepare    # install dependencies
    make clean      # start over again
    make up         # vagrant up, in an idempotent way
    make harden     # run the hardening
    make audit      # verify the hardening
    make packer     # build the centos image with packer
    make box        # add the packer built box for use by vagrant
    make demo       # run the demo

The Vagrantfile defines a virtual machine with Centos 6, you can login to it:

    vagrant ssh

The provision.yml playbook defines what is done during the first run of the VM's.

Centos can be used in your first exploration of this demo.
Enter these commands with vagransible as the work directory:

    'make prepare' # download the required roles

    'make demo'    # create a centos base images for virtualbox


To show how security can be improved with Ansible:

    'make harden'  # run the RHEL6-STIG role to create a USG compliant VM

    'make audit'   # check if the VM is indeed compliant
