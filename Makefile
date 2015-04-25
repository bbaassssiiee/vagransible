
install:
	ansible-playbook -v -i ansible.ini -l local install.yml

clean:
	vagrant destroy -f
	rm -rf roles
	
test:
	ansible-playbook --private-key=vagrant.rsa -i ansible.ini -l all playbooks/test_java.yml

centos:
	vagrant up --no-provision centos6
	vagrant provision centos6
	
stig: 
	ansible-playbook --private-key=vagrant.rsa -i ansible.ini -l centos6 RHEL-STIG1.yml RHEL-STIG2.yml
	ansible-playbook --private-key=vagrant.rsa -i ansible.ini -l centos6 playbooks/security_audit.yml

coreos: install
	vagrant up --no-provision coreos
	vagrant provision coreos

ubuntu: install
	vagrant up --no-provision ubuntu14
	vagrant provision ubuntu14

rancheros: 
	vagrant up --no-provision rancheros --provider=virtualbox
	vagrant provision rancheros

all: roles centos ubuntu coreos rancheros test

vagrant-vmware-fusion:
	vagrant plugin install vagrant-vmware-fusion
	vagrant plugin license vagrant-vmware-fusion ~/Downloads/license.lic

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
