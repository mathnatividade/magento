#!/bin/bash
sudo yum update -y
sudo yum install -y httpd

sudo yum install nfs-utils -y 
sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_mount_target.app_mount_1.ip_address}:/ /var/www/html
cd /var/www/html
sudo chmod go+rw /var/www/html
touch index.html
echo "<h1>Ola mundo, falando diretamente da instancia $(hostname -f) que esta em um ASG com ALB! E usando o EFS ${aws_efs_file_system.magento_app_files.dns_name} montado na pasta /var/www/html! </h1>" > /var/www/html/index.html
sudo systemctl start httpd
sudo systemctl enable httpd
sudo systemctl enable nfs
echo sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_mount_target.app_mount_1.ip_address}:/ /var/www/html  | sudo tee -a /etc/rc.d/rc.local
sudo chmod +x /etc/rc.d/rc.local

#sudo apt install mysql-client -y
#mysql -h ${aws_db_instance.magento_db_mysql.dns_name} -P 3306 -u magento --password[=magento]



#sudo apt install nfs-kernel-server

#sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport 10.0.175.51:/ /var/www/check
