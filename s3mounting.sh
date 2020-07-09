#!/bin/bash  

#TAMBAHIN SCRIPT GIT CLONE NYA

echo "Installing NGINX"
sudo apt update 
sudo apt install nginx php-fpm -y  

# DATABASE 
echo "Sedang menginstall Database Mysql-Server" 
sudo apt update 
sudo apt install mysql-server -y

# LIBRARY PHP-MYSQL
sudo apt update 
sudo apt install php-mysql -y

# MYSQL-CLIENT
sudo apt update
sudo apt install mysql-client -y

echo "Installing All Dependencies"
sudo apt update
sudo apt-get install automake autotools-dev fuse g++ git libcurl4-gnutls-dev libfuse-dev libssl-dev libxml2-dev make pkg-config


#TAMBAHIN SCRIPT GIT CLONE NYA

echo "Installing git.."
sudo apt update 
sudo apt install git 

# CLONE S3 DARI GIT
git clone https://github.com/vhico07/small-project1.git
git clone https://github.com/s3fs-fuse/s3fs-fuse.git
cd s3fs-fuse
./autogen.sh
./configure --prefix=/usr --with-openssl
make
sudo make install

# CONFIRM
which s3fs

# GETTING SECURE KEY FROM AWS ACCOUNT
cat > /etc/passwd-s3fs	<<EOF
acces key
EOF

# PERMISSION FILE KEYNYA
sudo chmod 640 /etc/passwd-s3fs

# CREATE DIRECTORY
mkdir /mys3bucket
s3fs gawaistudio -o use_cache=/tmp -o allow_other -o uid=1001 -o mp_umask=002 -o multireq_max=5 /mys3bucket
cat > /etc/rc.local	<<EOF
/usr/bin/s3fs gawaistudio -o use_cache=/tmp -o allow_other -o uid=1001 -o mp_umask=002 -o multireq_max=5 /mys3bucket
EOF

ls /mys3bucket



# VARIABLE  
VHOST_AVAILABLE='/etc/nginx/sites-available' 
VHOST_ENABLED='/etc/nginx/sites-enabled' 
VHOST_DEL_AVAIL='/etc/nginx/sites-available/default'
VHOST_DEL_ENAB='/etc/nginx/sites-enabled/default'


# DOCUMENT ROOT CONFIG  
cat > $VHOST_AVAILABLE/fesbuk	<<EOF
server {     
	listen 80;

	root /home/ubuntu/small-project1;

	index index.php index.html index.htm index.nginx-debian.html;

	server_name fesbuk.gonnabegood.xyz;
	
	location / {
		try_files \$uri \$uri/ =404;
	}
	
	location ~ \.php$ {
		include snippets/fastcgi-php.conf;
		fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
	}
	
	location ~ /\.ht {
		deny all;
	}
}
EOF

# DELETING DOCUMENT DEFAULT 
echo "Menghapus file default pada $VHOST_DEL_AVAIL"
sudo rm -rvf $VHOST_DEL_AVAIL 
echo "Menghapus file default pada $VHOST_DEL_ENAB"
sudo rm -rvf $VHOST_DEL_ENAB

# RESTART AND LINK NGINX SERVER
echo "Debug Error Document Root"
sudo nginx -t
echo "Symlink between sites-enabled and sites-available"
sudo ln -s /etc/nginx/sites-available/fesbuk /etc/nginx/sites-enabled/fesbuk
echo "Restarting Nginx server"
sudo systemctl restart nginx
echo "Selesai restart server"

# CREATE DATABASE
#sudo mysql -h database-master.ckw1ddumtncz.ap-southeast-1.rds.amazonaws.com -u root -p$PASS	<<EOF
#create database dbsosmed;
#show databases;
#EOF

# IMPORT DATA
#echo "Sedang import data ke dalam database"
#sudo mysql -h database-master.ckw1ddumtncz.ap-southeast-1.rds.amazonaws.com -u root -p$DBPASS dbsosmed < /home/ubuntu/small-project1/dump.sql
#echo "Selesai Import DATABASE"
