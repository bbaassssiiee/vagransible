VAGRANT_DEFAULT_PROVIDER=virtualbox
DOWNLOADS=/tmp/


help:
	@echo 'available make targets:'
	@grep PHONY: Makefile | cut -d: -f2 | sed 's/^/make/'

.PHONY: prepare    # install dependencies
prepare:
	./prepare -v

roles: prepare

.PHONY: clean      # start over again
clean:
	vagrant destroy -f
	rm -rf output-virtualbox-iso
	rm -f packer/virtualbox-centos6.box
	vagrant box remove centos6 || true

.PHONY: up         # vagrant up, in an idempotent way
up: roles
	vagrant up --no-provision centos6
	vagrant provision centos6

.PHONY: harden     # run the hardening
harden:
	ansible-playbook --private-key=pki/vagrant.rsa -l centos6 playbooks/RHEL-STIG1.yml

.PHONY: audit      # verify the hardening
audit:
	ansible-playbook --private-key=pki/vagrant.rsa -l centos6 playbooks/security_audit.yml
	open /tmp/rhel-stig-report.html

.PHONY: packer     # build the centos image with packer
packer/virtualbox-centos6.box:
	packer build packer-centos.json

.PHONY: box        # add the packer built box for use by vagrant
box: packer/virtualbox-centos6.box
	vagrant box add --name=centos6 packer/virtualbox-centos6.box
	vagrant up --no-provision centos6

.PHONY: demo       # run the demo
demo: clean packer box up harden audit

vm_centos: # using vmware
	vagrant up --no-provision centos6 --provider vmware_fusion
	vagrant provision centos6
