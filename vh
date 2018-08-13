#! /bin/bash
vh_name=$1;
curent_path=`pwd`
file_name_path='/tmp/'$vh_name'.conf'

#to generate the conf file in /tmp
printf  "<VirtualHost *:80>\n" >/tmp/$vh_name.conf
printf "  ServerAlias ${vh_name}\n" >>/tmp/$vh_name.conf
printf "  ServerName ${vh_name}\n" >>/tmp/$vh_name.conf
printf  "  DocumentRoot ${curent_path}\n" >>/tmp/$vh_name.conf
printf  "  <Directory ${curent_path}>\n" >>/tmp/$vh_name.conf
printf  "    Options Indexes FollowSymLinks\n">>/tmp/$vh_name.conf
printf  "    Require all granted\n">>/tmp/$vh_name.conf
printf  "    AllowOverride all\n">>/tmp/$vh_name.conf
printf  "    Allow from All\n">>/tmp/$vh_name.conf
printf  "  </Directory>\n">>/tmp/$vh_name.conf
printf  "  ErrorLog \${APACHE_LOG_DIR}/error.log\n">>/tmp/$vh_name.conf
printf  "  CustomLog \${APACHE_LOG_DIR}/access.log combined\n">>/tmp/$vh_name.conf
printf  "</VirtualHost>\n">>/tmp/$vh_name.conf

sudo cp $file_name_path /etc/apache2/sites-available/$vh_name.conf
rm $file_name_path

sudo a2ensite $vh_name.conf

(sudo echo "127.0.0.1	"${vh_name} && sudo cat /etc/hosts) > /tmp/hosts && sudo mv /tmp/hosts /etc/hosts

sudo systemctl restart apache2
