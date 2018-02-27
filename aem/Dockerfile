FROM airdock/oracle-jdk:1.8

LABEL maintainer=sii.pl

WORKDIR /aem

# https://vsupalov.com/docker-build-time-env-values/
ARG AEM_RUNMODE=author
ENV CQ_RUNMODE=$AEM_RUNMODE

COPY aem_packages/*.jar /aem/aem.jar
COPY aem_packages/license.properties /aem/license.properties

RUN mkdir -p /aem/crx-quickstart/install
COPY install_packages/* /aem/crx-quickstart/install/

WORKDIR /aem

RUN java -jar aem.jar -unpack -r nosamplecontent

WORKDIR /aem/crx-quickstart/bin
COPY ./scripts/run.sh /aem/crx-quickstart/bin/run.sh

WORKDIR /aem/crx-quickstart
COPY jstatd.all.policy /aem/crx-quickstart/jstatd.all.policy
COPY jstatd_run /aem/crx-quickstart/jstatd_run
RUN chmod +x /aem/crx-quickstart/jstatd_run

EXPOSE 80 10000 2000
ENTRYPOINT ["/aem/crx-quickstart/bin/run.sh"]
