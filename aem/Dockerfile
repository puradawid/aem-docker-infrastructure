FROM airdock/oracle-jdk:1.8

LABEL maintainer=sii.pl

WORKDIR /aem

COPY aem_packages/*.jar /aem/aem.jar
COPY aem_packages/license.properties /aem/license.properties

RUN mkdir -p /aem/crx-quickstart/install
COPY install_packages/* /aem/crx-quickstart/install/

WORKDIR /aem

RUN java -jar aem.jar -unpack -r nosamplecontent

WORKDIR /aem/crx-quickstart/bin
COPY ./scripts/run.sh /aem/crx-quickstart/bin/run.sh

WORKDIR /aem/crx-quickstart

# https://vsupalov.com/docker-build-time-env-values/
ARG AEM_RUNMODE=author
ENV CQ_RUNMODE=$AEM_RUNMODE

EXPOSE 80 10000 2000
ENTRYPOINT ["/aem/crx-quickstart/bin/run.sh"]
