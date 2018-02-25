FROM httpd:2.4

COPY mod_dispatcher/dispatcher-apache2.4-4.2.3.so /usr/local/apache2/modules/mod_dispatcher.so
COPY mod_dispatcher/conf/httpd.conf.disp2 /usr/local/apache2/conf/httpd.conf
COPY mod_dispatcher/conf/dispatcher.any /usr/local/apache2/conf/dispatcher.any

RUN /usr/local/apache2/bin/apachectl -t
