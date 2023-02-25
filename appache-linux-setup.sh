
	sudo su -
	yum install httpd -y
	systemctl status httpd
	systemctl start httpd
	systemctl enable httpd


	echo"<h1>Hello World from $(hostname, -f)</h1>" >/var/www/html/index.html
