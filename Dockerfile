# we will inherit from  the Debian image on DockerHub
FROM debian

# set timezone so files' timestamps are correct
ENV TZ=Europe/Madrid

# install apache and php 7.3
# we include procps and telnet so you can use these with shell.sh prompt
RUN apt-get update -y -qq >/dev/null \
    && apt-get install -y apache2 libapache2-mod-evasive >/dev/null \
    && apt-get purge --auto-remove \
    && apt-get clean \
    && mkdir -p /var/log/mod_evasive \
    && chown -R root:www-data /var/log/mod_evasive

# HTML server directory
WORKDIR /var/www/html
COPY entrypoint.sh /var/www/html/
COPY evasive.conf /etc/apache2/mods-available/evasive.conf

RUN service apache2 restart
# we run a script to stat the server; the array syntax makes it so ^C will work as we want
CMD  ["./entrypoint.sh"]
