# Adobe Experience Manager on Docker - example of entire infrastructure

This project meant to be an example for companies that trying to create AEM
infrastructure in DevOps manner.

## Requirements

This *can* be in smaller minor versions, although it was tested in this way.

* Docker (>= 17.12.ce)
* Maven (>= 3.3.9)
* AEM jar (>= 6.1) + **license.properties** file

## How to run infrastructure

Unfortunately, there is no AEM jar provided because of licensing and size of
this repository.

To run any AEM you need to put three elements into:

- one of AEM 6.1, 6.2 or 6.3 (all tested) jars into `aem/aem_packages`
  - the name does not matter - it can be any `*.jar`.
- license.properties file - this has to be named that way
- unzipped mod_dispatcher content `dispatcher/mod_dispatcher` for Apache 2.4
  that can be downloaded from [Adobe PackageShare][1]

After putting thse files, just type:

     ./update-conf-package
     docker-compose up

## Entry points

1. port 4502 - author
2. port 4503 - publish
3. port 8080 - dispatcher (example `http://localhost:8080/content/we-retail/us/en.html`)
4. port 8888 - proxy for browsers

### How to enter domain

Firefox and all other browsers provides [proxy configuration][2]. What you need
to do is configure proxy and use it in order to access configured domains (like
geometrixxselling.com) inside your network.

### Installing packages into AEM instance

There is an option to enhance AEM docker file with your custom/update packages
(i.e.cumulative fix packs or your own app packages). In order to do so, you have
to change the Dockerfile (or import this one using FROM) and add more packages
by:

    COPY aem_packages/your-custom-package.zip crx-quickstart/install/
    RUN ./crx-quickstart/bin/install.sh

It will copy the package (obviously), but also will run AEM and wait until
the package is installed. That gives you an opportunity to store JCR repository
as it is in installed state, do not making the image boot up with installation
process, which can't be always properly maintained/verified - and also it saves
time of potential image user (which doesn't build this image from scratch).

[1]: https://www.adobeaemcloud.com/content/companies/public/adobe/dispatcher/dispatcher/_jcr_content/top/download_8/file.res/dispatcher-apache2.4-linux-x86-64-4.2.3.tar.gz
[2]: https://support.mozilla.org/en-US/kb/connection-settings-firefox
