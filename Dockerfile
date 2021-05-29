FROM ubuntu:20.04
RUN apt-get update &&\
    apt-get install software-properties-common -y &&\
    add-apt-repository ppa:ondrej/php -y &&\
    apt-get install -y wget nginx php7.4-fpm  php7.4-common php7.4-mysql php7.4-gmp php7.4-curl php7.4-intl php7.4-mbstring php7.4-xmlrpc php7.4-gd php7.4-xml php7.4-cli php7.4-zip

WORKDIR  /tmp
RUN wget https://wordpress.org/latest.tar.gz &&\
tar -xvzf latest.tar.gz &&\
mv wordpress /var/www/wordpress &&\
chown -R www-data:www-data /var/www/wordpress/ &&\
chmod -R 755 /var/www/wordpress/ 

RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN rm /etc/nginx/sites-enabled/default
COPY wordpress /etc/nginx/sites-available/wordpress
RUN ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/ 

EXPOSE 80
CMD service php7.4-fpm start && nginx