#!/bin/bash

# Update package lists
sudo apt update

# Install Apache2
sudo apt install -y apache2

# Adjust Firewall Settings
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw enable

# Configure Apache2 Virtual Host (Change example.com to your domain)
sudo tee /etc/apache2/sites-available/example.com.conf > /dev/null <<EOF
<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  ServerName master.test.bioconductor.org

  # Customized ERROR responses
  ErrorDocument 404 /help/404/index.html
  ErrorDocument 403 /help/403/index.html

  # DocumentRoot: The directory out of which you will serve your
  # documents. By default, all requests are taken from this directory, but
  # symbolic links and aliases may be used to point to other locations.
  DocumentRoot /extra/www/bioc

  # if not specified, the global error log is used
  LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" awstats
  ErrorLog /var/log/apache2/bioconductor-error.log
  CustomLog /var/log/apache2/bioconductor-access.log awstats
  ScriptAlias /cgi-bin/ "/usr/local/awstats/wwwroot/cgi-bin/"
  ScriptAlias /cgi/ "/usr/local/cgi/"

  # don't loose time with IP address lookups
  HostnameLookups Off

  # needed for named virtual hosts
  UseCanonicalName Off

  ServerSignature On

    # For most configuration files from conf-available/, which are
    # enabled or disabled at a global level, it is possible to
    # include a line for only one particular virtual host. For example the
    # following line enables the CGI configuration for this host only
    # after it has been globally disabled with "a2disconf".
    #Include conf-available/serve-cgi-bin.conf

  # doc root
  <Directory /extra/www/bioc/>
      Options FollowSymLinks
      AllowOverride All
      #Controls who can get stuff from this server
      #Order allow,deny
      #Allow from all
      Require all granted

     AddOutputFilterByType DEFLATE text/html text/css application/javascript text/x-js
     BrowserMatch ^Mozilla/4 gzip-only-text/html
     BrowserMatch ^Mozilla/4\.0[678] no-gzip
     BrowserMatch \bMSIE !no-gzip !gzip-only-text/html

  </Directory>

  <Directory /extra/www/bioc/checkResults/>
      Options Indexes FollowSymLinks
  </Directory>
  <Directory /extra/www/bioc/packages/submitted/>
      Options Indexes
  </Directory>
  <Directory /extra/www/bioc/packages/misc/>
      Options Indexes
  </Directory>
  <Directory /extra/www/bioc/pending/>
      Options Indexes
  </Directory>
  <Directory /extra/www/bioc/data/>
      Options Indexes
  </Directory>
  <Directory /extra/www/bioc/packages/3.6/bioc/src/contrib/Archive/>
      Options Indexes FollowSymLinks MultiViews
      AllowOverride All
  </Directory>
  <Directory /extra/www/bioc/packages/3.7/bioc/src/contrib/Archive/>
      Options Indexes FollowSymLinks MultiViews
      AllowOverride All
  </Directory>
  <Directory /extra/www/bioc/packages/3.8/bioc/src/contrib/Archive/>
      Options Indexes FollowSymLinks MultiViews
      AllowOverride All
  </Directory>
  <Directory /extra/www/bioc/packages/3.9/bioc/src/contrib/Archive/>
      Options Indexes FollowSymLinks MultiViews
      AllowOverride All
  </Directory>
  <Directory /extra/www/bioc/packages/3.10/bioc/src/contrib/Archive/>
      Options Indexes FollowSymLinks MultiViews
      AllowOverride All
  </Directory>
  <Directory /extra/www/bioc/packages/3.11/bioc/src/contrib/Archive/>
      Options Indexes FollowSymLinks MultiViews
      AllowOverride All
  </Directory>

 # configure the Apache web server to work with Solr
 ProxyRequests Off
 <Proxy *>
   Order deny,allow
   Allow from all
 </Proxy>
 ProxyPass /solr/default/select http://localhost:8983/solr/default/select
 ProxyPreserveHost On
 ProxyStatus On
</VirtualHost>
EOF

# Enable the virtual host
sudo a2ensite example.com.conf

#Enable all the necessary modules 
sudo a2enmod rewrite
sudo a2enmod expires

# Reload Apache2
sudo systemctl reload apache2

#restart Apache2
sudo systemctl restart apache2

echo "Apache2 setup completed successfully."

