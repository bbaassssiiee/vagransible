VAGRANT_DEFAULT_PROVIDER=virtualbox
DOWNLOADS=/tmp/

install:
	ansible-playbook -v -i ansible.ini -l local install.yml

	@wget --limit-rate=10m --tries=10 --retry-connrefused --waitretry=180 --directory-prefix=${DOWNLOADS} --no-clobber \
	http://www.mirrorservice.org/sites/mirror.centos.org/6/isos/x86_64/CentOS-6.6-x86_64-netinstall.iso \
	|| mv ${DOWNLOADS}/CentOS-6.6-x86_64-netinstall.iso ${DOWNLOADS} || true

clean:
	vagrant destroy -f
	

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
	vagrant box add --name=dockpack/centos6 packer/virtualbox-centos6.box
	vagrant up --no-provision centos6
	vagrant provision centos6

all: install box stig audit

demo:	install centos stig audit

fedora21:
	vagrant up --no-provision fedora21
	vagrant provision fedora21

docker: fedora21
	ansible-playbook --private-key=pki/vagrant.rsa -i ansible.ini -l fedora21 playbooks/install_docker.yml

coreos: install
	vagrant up --no-provision coreos
	vagrant provision coreos

ubuntu: install
	vagrant up --no-provision ubuntu14
	vagrant provision ubuntu14

rancheros: 
	vagrant up --no-provision rancheros --provider=virtualbox
	vagrant provision rancheros

vm_centos: roles
	vagrant up --no-provision centos6 --provider vmware_fusion
	vagrant provision centos6
	
vm_coreos: roles
	vagrant up --no-provision coreos --provider vmware_fusion
	vagrant provision coreos

vm_ubuntu: roles
	vagrant up --no-provision ubuntu14 --provider vmware_fusion
	vagrant provision ubuntu14


	
