sudo useradd -m -d /home/${1} -s /bin/bash ${1}
sudo mkdir /home/${1}/.ssh
cd /home/julia/System-Admin-Network-Services-II
sudo cp SYS265/linux/public-keys/id_rsa.pub /home/${1}/.ssh/authorized_keys
sudo chmod 700 /home/${1}/.ssh
sudo chmod 600 /home/${1}/.ssh/authorized_keys
sudo chown -R ${1}:${1} /home/${1}/.ssh

if grep -q "^PermitRootLogin" /etc/ssh/sshd_config; then
	sudo sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
else
	echo "PermitRootLogin not found in /etc/ssh/sshd_config"
fi

sydo systemctl restart sshd.service
