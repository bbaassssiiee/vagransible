VAGRANT_DEFAULT_PROVIDER=virtualbox
DOWNLOADS=/tmp/

install:
	ansible-playbook -v -i ansible.ini -l local install.yml

	@wget --limit-rate=10m --tries=10 --retry-connrefused --waitretry=180 --directory-prefix=${DOWNLOADS} --no-clobber \
	http://www.mirrorservice.org/sites/mirror.centos.org/6/isos/x86_64/CentOS-6.6-x86_64-netinstall.iso \
	|| mv ${DOWNLOADS}/CentOS-6.6-x86_64-netinstall.iso ${DOWNLOADS} || true

clean:
	vagrant destroy -f
	
test:
	ansible-playbook --private-key=pki/vagrant.rsa -i ansible.ini -l all playbooks/test_java.yml

centos:
	vagrant up --no-provision centos6
	vagrant provision centos6
	
stig: 
	ansible-playbook --private-key=pki/vagrant.rsa -i ansible.ini -l centos6 playbooks/RHEL-STIG1.yml

audit:
	ansible-playbook --private-key=pki/vagrant.rsa -i ansible.ini -l centos6 playbooks/security_audit.yml
	open /tmp/rhel-stig-report.html

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

all: roles centos fedora21 ubuntu coreos rancheros test

vm_centos: roles
	vagrant up --no-provision centos6 --provider vmware_fusion
	vagrant provision centos6
	
vm_coreos: roles
	vagrant up --no-provision coreos --provider vmware_fusion
	vagrant provision coreos

vm_ubuntu: roles
	vagrant up --no-provision ubuntu14 --provider vmware_fusion
	vagrant provision ubuntu14
	
vmware: roles vm_centos vm_ubuntu vm_coreos test
# real	5m0.892s
virtualbox: roles vb_centos vb_ubuntu vb_coreos test
# real	5m31.375s

demo:	install centos stig audit
	
