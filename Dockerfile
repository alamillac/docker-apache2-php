# apache2-php
#
# VERSION               2.0

FROM     alamilla/base
MAINTAINER Andres F. Lamilla, "alamilla@gmail.com"

# actualizacion repositorio
RUN apt-get update -qq

# instalacion de los paquetes necesarios para la app
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 php5

# se modifica el directorio /var/www/html
RUN rm -rf /var/www/html

RUN mkdir -p /opt/app/public
RUN ln -s /opt/app/public/ /var/www/html

RUN a2enmod rewrite
RUN a2enmod headers

# se adicionan los archivos template de configuracion
ADD src/apache2.sv.conf /etc/supervisor/conf.d/apache2.sv.conf
ADD src/run.sh /usr/local/bin/run.sh
ADD src/start_apache2.sh /usr/local/bin/start_apache2.sh
RUN chmod +x /usr/local/bin/*.sh

EXPOSE 80
CMD ["/usr/local/bin/run.sh"]
