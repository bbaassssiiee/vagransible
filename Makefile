VAGRANT_DEFAULT_PROVIDER=virtualbox
DOWNLOADS=/tmp/

install:
	ansible-playbook -v -i ansible.ini -l local install.yml

clean:
	vagrant destroy -f
	rm -rf output-virtualbox-iso
	rm -f packer/virtualbox-centos6.box
	vagrant box remove centos6

download:
	@wget --limit-rate=10m --tries=10 --retry-connrefused --waitretry=180 --directory-prefix=${DOWNLOADS} --no-clobber \
	http://www.mirrorservice.org/sites/mirror.centos.org/6/isos/x86_64/CentOS-6.9-x86_64-minimal.iso \
	|| mv ${DOWNLOADS}/CentOS-6.9-x86_64-minimal.iso ${DOWNLOADS} || true

centos:
	vagrant up --no-provision centos6
	vagrant provision centos6

stig:
	ansible-playbook --private-key=pki/vagrant.rsa -i ansible.ini -l centos6 playbooks/RHEL-STIG1.yml

audit:
	ansible-playbook --private-key=pki/vagrant.rsa -i ansible.ini -l centos6 playbooks/security_audit.yml
	open /tmp/rhel-stig-report.html
	open /tmp/vulnerability-report.html

packer/virtualbox-centos6.box:
	packer build packer-centos.json

test:
	ansible-playbook --private-key=pki/vagrant.rsa -i ansible.ini -l all playbooks/test_java.yml

box: packer/virtualbox-centos6.box
	vagrant box add --name=centos6 packer/virtualbox-centos6.box
	vagrant up --no-provision centos6

all: clean box audit

demo: centos stig audit

vm_centos: roles
	vagrant up --no-provision centos6 --provider vmware_fusion
	vagrant provision centos6
