sudo -i
	sudo apt update
	sudo apt install apache2 wget unzip -y
	wget https://www.tooplate.com/zip-templates/2128_tween_agency.zip
	unzip 2128_tween_agency.zip
	cp -r 2128_tween_agency/* /var/www/html/
	systemctl restart apache2
	ls /var/www/html/
	systemctl status apache2
