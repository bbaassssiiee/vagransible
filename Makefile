roles:
	ansible-playbook -v -i ansible.ini -l local install.yml

clean:
	vagrant destroy -f
	rm -rf roles

centos: roles
	vagrant up --no-provision centos6
	vagrant provision centos6
	
coreos: roles
	vagrant up --no-provision coreos
	vagrant provision coreos

ubuntu: roles
	vagrant up --no-provision ubuntu14
	vagrant provision ubuntu14
	
test:
	ansible-playbook --private-key=vagrant.rsa -i ansible.ini -l all playbooks/test_java.yml

all: roles centos ubuntu coreos test
