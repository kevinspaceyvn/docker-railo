FROM ubuntu:trusty
MAINTAINER Daniel Mahon <daniel@mahonstudios.com>

# Install packages
RUN apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install apache2 git mysql-server supervisor wget expect

# Get Railo
RUN wget http://www.getrailo.org/down.cfm?item=/railo/remote/download42/4.2.1.000/tomcat/linux/railo-4.2.1.000-pl1-linux-x64-installer.run -O railo.run

# Set permissions
RUN chmod 744 railo.run

# Run Railo Installer
ADD install_railo.sh /install_railo.sh
RUN /install_railo.sh
RUN service apache2 restart

# Add image configuration and scripts
ADD start-apache2.sh /start-apache2.sh
ADD start-mysqld.sh /start-mysqld.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh
ADD my.cnf /etc/mysql/conf.d/my.cnf
ADD supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
ADD supervisord-mysqld.conf /etc/supervisor/conf.d/supervisord-mysqld.conf

# Remove pre-installed database
RUN rm -rf /var/lib/mysql/*

# Add MySQL utils
ADD create_mysql_admin_user.sh /create_mysql_admin_user.sh
ADD import_sql.sh /import_sql.sh
ADD create_db.sh /create_db.sh
RUN chmod 755 /*.sh

# config to enable .htaccess
ADD apache_default /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite

# Configure /app folder with sample app
RUN git clone https://github.com/fermayo/hello-world-lamp.git /app
RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html

# Add volumes for MySQL 
VOLUME  ["/etc/mysql", "/var/lib/mysql" ]

EXPOSE 80 8888 8005 8009 3306
CMD ["/run.sh"]
