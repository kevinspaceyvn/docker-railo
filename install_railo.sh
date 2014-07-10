#!/usr/bin/expect -f

set timeout 20

spawn "./railo.run"

expect "Please choose an option \\\[4\\\] : "
send "4\r"

set timeout 2

expect "Press \\\[Enter\\\] to continue : "
send "\r"
expect "Press \\\[Enter\\\] to continue : "
send "\r"
expect "Do you accept this license? : "
send "y\r"
expect "Installation Directory \\\[/opt/railo\\\]: "
send "\r"
expect "Railo Password : "
send "changeme\r"
expect "Railo Password (confirm) : "
send "changeme\r"
expect "Tomcat Web Server Port: \\\[8888\\\]: "
send "\r"
expect "Tomcat Shutdown Port: \\\[8005\\\]: "
send "\r"
expect "Tomcat AJP Port: \\\[8009\\\]: "
send "\r"
expect "Tomcat System User \\\[root\\\] : "
send "\r"
expect "Yes, Start Railo at Boot Time \\\[Y/n\\\]: "
send "y\r"
expect "Install Apache Connector? \\\[Y/n\\\]: "
send "y\r"
expect "Apache Control Script Location \\\[/usr/sbin/apachectl\\\] : "
send "\r"
expect "Apache Modules Directory \\\[/usr/lib/apache2/modules\\\] : "
send "\r"
expect "Apache Configuration File \\\[/etc/apache2/apache2.conf\\\] : "
send "\r"
expect "Apache Logs Directory \\\[/var/log/apache2\\\] : "
send "\r"
expect "Do you want to continue? \\\[Y/n\\\] : "
send "y\r"

set timeout -1

expect "$"
