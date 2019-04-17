#!/bin/sh

USER=vagrant
PASSWORD=vagrant

# wget https://releases.hashicorp.com/packer/1.3.4/packer_1.3.4_linux_amd64.zip
# unzip packer_1.3.4_linux_amd64.zip -d /tmp/packer
# sudo mv /tmp/packer/packer /usr/local/
# export PATH="$PATH:/usr/local/packer"
# source /etc/environment

# add addresses to /etc/hosts 
echo "192.168.99.155 ansible.test.local" | sudo tee -a /etc/hosts 
echo "192.168.99.154 gitlab.test.local" | sudo tee -a /etc/hosts 
echo "192.168.99.153 jenkins.test.local" | sudo tee -a /etc/hosts 
echo "192.168.99.152 docker.test.local" | sudo tee -a /etc/hosts 
echo "192.168.99.151 nfsclient.test.local" | sudo tee -a /etc/hosts
echo "192.168.99.150 nfsserver.test.local" | sudo tee -a /etc/hosts
echo "192.168.99.156 W01-2012.test.local" | sudo tee -a /etc/hosts   

echo " " | sudo tee -a /etc/ansible/hosts
echo "[all]" | sudo tee -a /etc/ansible/hosts
echo "gitlab.test.local" | sudo tee -a /etc/ansible/hosts 
echo "jenkins.test.local" | sudo tee -a /etc/ansible/hosts 
echo "docker.test.local" | sudo tee -a /etc/ansible/hosts 
echo "nfsclient.test.local" | sudo tee -a /etc/ansible/hosts
echo "nfsserver.test.local" | sudo tee -a /etc/ansible/hosts
echo "W01-2012.test.local" | sudo tee -a /etc/ansible/hosts  

echo " " | sudo tee -a /etc/ansible/hosts
echo "[test]" | sudo tee -a /etc/ansible/hosts
echo "nfsserver.test.local" | sudo tee -a /etc/ansible/hosts
echo "nfsclient.test.local" | sudo tee -a /etc/ansible/hosts

echo " " | sudo tee -a /etc/ansible/hosts
echo "[nfs-server]" | sudo tee -a /etc/ansible/hosts
echo "nfsserver.test.local" | sudo tee -a /etc/ansible/hosts

echo " " | sudo tee -a /etc/ansible/hosts
echo "[nfs-clients]" | sudo tee -a /etc/ansible/hosts
echo "nfsclient.test.local" | sudo tee -a /etc/ansible/hosts

echo " " | sudo tee -a /etc/ansible/hosts
echo "[jenkins]" | sudo tee -a /etc/ansible/hosts
echo "jenkins.test.local" | sudo tee -a /etc/ansible/hosts

echo " " | sudo tee -a /etc/ansible/hosts
echo "[docker]" | sudo tee -a /etc/ansible/hosts
echo "docker.test.local" | sudo tee -a /etc/ansible/hosts

echo " " | sudo tee -a /etc/ansible/hosts
echo "[gitlab]" | sudo tee -a /etc/ansible/hosts
echo "gitlab.test.local" | sudo tee -a /etc/ansible/hosts

echo " " | sudo tee -a /etc/ansible/hosts
echo "[W01-2012]" | sudo tee -a /etc/ansible/hosts
echo "W01-2012.test.local" | sudo tee -a /etc/ansible/hosts

#cat /etc/ansible/hosts
dos2unix ~/artefacts/scripts/ssh_pass.sh
chmod +x ~/artefacts/scripts/ssh_pass.sh
#chown vagrant:vagrant ssh_pass.sh 

# password less authentication using expect scripting language
~/artefacts/scripts/ssh_pass.sh $USER $PASSWORD "ansible.test.local" 
~/artefacts/scripts/ssh_pass.sh $USER $PASSWORD "nfsclient.test.local" 
~/artefacts/scripts/ssh_pass.sh $USER $PASSWORD "nfsserver.test.local" 
~/artefacts/scripts/ssh_pass.sh $USER $PASSWORD "docker.test.local" 
~/artefacts/scripts/ssh_pass.sh $USER $PASSWORD "jenkins.test.local"
~/artefacts/scripts/ssh_pass.sh $USER $PASSWORD "gitlab.test.local"
~/artefacts/scripts/ssh_pass.sh $USER $PASSWORD "W01-2012.test.local"

ansible-playbook ~/artefacts/playbooks/nfs_server.yaml
ansible-playbook ~/artefacts/playbooks/nfs_clients.yaml
ansible-playbook ~/artefacts/playbooks/install_java.yaml
ansible-playbook ~/artefacts/playbooks/install_jenkins.yaml
ansible-playbook ~/artefacts/playbooks/install_docker.yaml
ansible-playbook ~/artefacts/playbooks/install_gitlab.yaml
ansible-playbook ~/artefacts/playbooks/ad.yaml