FROM ubuntu:18.04
#FROM ubuntu:16.04
MAINTAINER yidong <yidong@cnezsoft.com>

ENV LANG="en_US.UTF8"

RUN apt-get update && apt-get install -y apache2 mariadb-server php php-curl php-gd php-ldap php-mbstring php-mcrypt php-mysql php-xml php-zip php-cli php-json curl unzip libapache2-mod-php locales && \
    echo -e "LANG=\"en_US.UTF-8\"\nLANGUAGE=\"en_US:en\"" > /etc/default/locale && locale-gen en_US.UTF-8 && \
    mkdir -p /app/zentaopms
COPY docker-entrypoint.sh /app
RUN random=`date +%s`; curl http://cdn.zentaopm.com/latest/zentao.zip?rand=$random -o /var/www/zentao.zip && \
    cd /var/www/ && unzip -q zentao.zip && rm zentao.zip && \
    a2enmod rewrite && \
    rm -rf /etc/apache2/sites-enabled/000-default.conf /var/lib/mysql/* && \
    sed -i '1i ServerName 127.0.0.1' /etc/apache2/apache2.conf && \
	chmod +x /app/docker-entrypoint.sh

COPY config/apache.conf /etc/apache2/sites-enabled/000-default.conf
COPY config/ioncube_loader_lin_7.0.so /usr/lib/php/20151012/ioncube_loader_lin_7.0.so
COPY config/00-ioncube.ini /etc/php/7.0/apache2/conf.d/
COPY config/00-ioncube.ini /etc/php/7.0/cli/conf.d/

VOLUME /app/zentaopms /var/lib/mysql

EXPOSE 80

ENTRYPOINT ["/app/docker-entrypoint.sh"]
