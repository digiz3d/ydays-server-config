apt update && apt install -y git apache2 mariadb-server mariadb-client software-properties-common

sed -i "s/Options Indexes FollowSymLinks/Options FollowSymLinks/" /etc/apache2/apache2.conf

/etc/init.d/apache2 restart

systemctl restart mariadb.service

add-apt-repository ppa:ondrej/php

apt update && apt install -y php7.1 libapache2-mod-php7.1 php7.1-common php7.1-mbstring php7.1-xmlrpc php7.1-soap php7.1-apcu php7.1-smbclient php7.1-ldap php7.1-redis php7.1-gd php7.1-xml php7.1-intl php7.1-json php7.1-imagick php7.1-mysql php7.1-cli php7.1-mcrypt php7.1-ldap php7.1-zip php7.1-curl

cd ~/

git clone https://github.com/digiz3d/ydays-server-config.git

# Copie le fichier ini du dossier github 
yes | cp /ydays-server-config/php.ini /etc/php/7.1/apache2/php.ini

cd /var/www/ && wget https://download.owncloud.org/community/owncloud-10.0.3.zip

unzip owncloud-10.0.3.zip

chown -R www-data:www-data /var/www/owncloud/

chmod -R 755 /var/www/owncloud/

# Copie du fichier owncloud.conf du dossier github
yes | cp /ydays-server-config/owncloud.conf /etc/apache2/sites-available/owncloud.conf

a2ensite owncloud.conf

a2enmod rewrite

a2enmod headers

a2enmod env

a2enmod dir

a2enmod mime

systemctl restart apache2.service


