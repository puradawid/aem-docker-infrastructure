FROM airdock/oracle-jdk:1.8

LABEL maintainer=sii.pl

WORKDIR /aem

# Phase #1: install AEM jar provided, then license (all needed before run)
COPY aem_packages/*.jar /aem/aem.jar
COPY aem_packages/license.properties /aem/license.properties

# Phase #2: create packages install folder
RUN mkdir -p /aem/crx-quickstart/install

WORKDIR /aem

# Phase #3: unpack AEM insatnce and copy enahnced run script
RUN java -jar aem.jar -unpack -r nosamplecontent -nobrowser

WORKDIR /aem/crx-quickstart/bin
COPY ./scripts/run.sh /aem/crx-quickstart/bin/run.sh
COPY ./scripts/install.sh /aem/crx-quickstart/bin/install.sh

WORKDIR /aem/crx-quickstart
# Phase #4: provide information which runmode this instance goes with
# https://vsupalov.com/docker-build-time-env-values/
ARG AEM_RUNMODE=author
ENV CQ_RUNMODE=$AEM_RUNMODE

WORKDIR /aem
RUN ./crx-quickstart/bin/install.sh

#This is an example how to install packages - put them into content folder and then run install.sh
#COPY install_packages/AEM-6.3.3.0-6.3.3.zip crx-quickstart/install/
#RUN ./crx-quickstart/bin/install.sh

#COPY install_packages/AEM-CFP-6.3.3.8-8.0.zip crx-quickstart/install/
#RUN ./crx-quickstart/bin/install.sh

EXPOSE 80 10000 2000
ENTRYPOINT ["/aem/crx-quickstart/bin/run.sh"]
