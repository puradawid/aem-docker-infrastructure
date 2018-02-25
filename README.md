# Adobe Experience Manager on Docker - example of entire infrastructure

This project meant to be an example for companies that trying to create AEM
infrastructure in DevOps manner.

## How to run infrastructure

Unfortunately, there is no AEM jar provided because of licensing and size of
this repository.

To run any AEM you need to put three elements into:

- AEM 6.1, 6.2 or 6.3 (all tested) jars into `aem/aem_packages`
  - the name does not matter - it can be any `*.jar`.
- license.properties file - this has to be named that way
- unzipped mod_dispatcher content `dispatcher/mod_dispatcher` for Apache 2.4
  that can be downloaded from [Adobe PackageShare][1]

After putting thse files, just type:

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

[1]: https://www.adobeaemcloud.com/content/companies/public/adobe/dispatcher/dispatcher/_jcr_content/top/download_8/file.res/dispatcher-apache2.4-linux-x86-64-4.2.3.tar.gz
[2]: https://support.mozilla.org/en-US/kb/connection-settings-firefox
