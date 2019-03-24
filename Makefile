VAGRANT_DEFAULT_PROVIDER=virtualbox
DOWNLOADS=/tmp/
M=6

help:
	@echo 'available make targets:'
	@grep PHONY: Makefile | cut -d: -f2 | sed '1d;s/^/make/'

.PHONY: prepare    # install dependencies
prepare:
	./prepare -v

roles: prepare

.PHONY: packer     # build the centos image with packer
packer:
	packer build packer-centos${M}.json

packer/virtualbox-centos${M}.box: packer

.PHONY: box        # add the packer built box for use by vagrant
box: packer/virtualbox-centos${M}.box
	vagrant box add --force --name=centos${M} packer/virtualbox-centos${M}.box
	vagrant up --no-provision centos${M}
	vagrant ssh

.PHONY: up         # vagrant up, in an idempotent way
up: roles
	vagrant up --no-provision centos${M}
	vagrant provision centos${M}

.PHONY: clean      # start over again
clean:
	vagrant destroy -f
	rm -rf output-virtualbox-iso
	rm -f packer/virtualbox-centos${M}.box
	vagrant box remove centos${M} || true

.PHONY: harden     # run the hardening
harden:
	ansible-playbook --private-key=pki/vagrant.rsa -l centos6 playbooks/RHEL-STIG1.yml

.PHONY: audit      # verify the hardening
audit:
	ansible-playbook --private-key=pki/vagrant.rsa -l centos6 playbooks/security_audit.yml
	open /tmp/rhel-stig-report.html

.PHONY: demo       # run the demo
demo: clean prepare packer box up harden audit
