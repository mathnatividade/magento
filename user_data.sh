#!/bin/bash
sudo yum update -y
sudo yum install -y httpd

sudo yum install nfs-utils -y 
sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.magento_app_files.dns_name}:/ /var/www/html
echo ${aws_efs_file_system.magento_app_files.dns_name}:/ /var/www/html nfs4 defaults,_netdev 0 0  | sudo cat >> /etc/fstab
sudo chmod go+rw /var/www/html

sudo systemctl start httpd
sudo systemctl enable httpd
echo "<h1>Ola mundo, falando diretamente da instancia $(hostname -f) que esta em um ASG com ALB! E usando o EFS ${aws_efs_file_system.magento_app_files.dns_name} montado na pasta /var/www/html! ${aws_db_instance.magento_db_mysql.dns_name}</h1>" > /var/www/html/index.html

#sudo apt install mysql-client -y
#mysql -h ${aws_db_instance.magento_db_mysql.dns_name} -P 3306 -u magento --password[=magento]