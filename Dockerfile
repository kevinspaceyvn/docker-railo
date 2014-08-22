FROM ubuntu:trusty
MAINTAINER Daniel Mahon <daniel@mahonstudios.com>

# Install packages
RUN apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install git wget expect

# Get Railo
RUN wget http://www.getrailo.org/down.cfm?item=/railo/remote/download42/4.2.1.000/tomcat/linux/railo-4.2.1.000-pl2-linux-x64-installer.run -O railo.run
RUN chmod 744 railo.run

# Run Railo Installer
RUN ./railo.run --mode unattended --railopass "123456"
#ADD install_railo.sh /install_railo.sh
#RUN /install_railo.sh
ADD server.xml /opt/railo/tomcat/conf/server.xml

# Add image configuration and scripts
ADD run.sh /run.sh
RUN chmod 755 /*.sh

EXPOSE 8888
CMD ["/run.sh"]
