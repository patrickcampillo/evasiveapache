# we will inherit from  the Debian image on DockerHub
FROM debian

# set timezone so files' timestamps are correct
ENV TZ=Europe/Madrid

# install apache and mod-evasive
RUN apt-get update -y -qq >/dev/null \
    && apt-get install -y apache2 libapache2-mod-evasive >/dev/null \
    && apt-get purge --auto-remove \
    && apt-get clean \
    && mkdir -p /var/log/mod_evasive \
    && chown -R root:www-data /var/log/mod_evasive

# HTML server directory
WORKDIR /var/www/html

#COPY of the entrypoint file, and the evasive configuration file
COPY entrypoint.sh /var/www/html/
COPY evasive.conf /etc/apache2/mods-available/evasive.conf

#RUN a restart of Apache
RUN service apache2 restart

#Entrypoint execution
CMD  ["./entrypoint.sh"]
