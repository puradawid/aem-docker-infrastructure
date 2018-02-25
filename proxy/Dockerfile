FROM httpd:2.4

RUN apt-get update && apt-get install -y knot-host

COPY ./httpd.conf /usr/local/apache2/conf
COPY ./add-host.sh /usr/bin/add-host
COPY ./start.sh /usr/bin/start-proxy-container

RUN /usr/local/apache2/bin/apachectl -t

ENTRYPOINT ["start-proxy-container"]
