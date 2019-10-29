#
# Install this using the following command:
#
# . <(curl -s https://raw.githubusercontent.com/johnkoerner/kali-scripts/master/install-dvwa.sh)

# Get dvwa from source
git clone https://github.com/ethicalhack3r/DVWA.git /var/www/html/dvwa
mv /var/www/html/dvwa/config/config.inc.php.dist  /var/www/html/dvwa/config/config.inc.php

# For the captcha tests
apt-get -y install php-gd

# Set permissions to allow bad stuff 
chmod -R 777 /var/www/html/dvwa/hackable/uploads
chmod -R 777 /var/www/html/dvwa/external/phpids
chmod -R 777 /var/www/html/dvwa/config

# enable some php settings for exploits
sed -i "s/allow_url_include = Off/allow_url_include = On/g" /etc/php/7.3/apache2/php.ini

# Ensure apache and mysql are running
service apache2 start
service mysql start

# Add a new user for the dvwa app
mysql --execute="drop user mysqluser;"
mysql --execute="use mysql; create user mysqluser identified by 'p@ssw0rd'; grant all privileges on *.* to mysqluser; update user set plugin='' where user='root'; flush privileges"

# change the dvwa config to use the new user
sed -i "s/$_DVWA[ 'db_user' ].*= 'root';/_DVWA[ 'db_user' ]     = 'mysqluser';/g"  /var/www/html/dvwa/config/config.inc.php 

# Open the browser to the dvwa
xdg-open "http://127.0.0.1/dvwa"
