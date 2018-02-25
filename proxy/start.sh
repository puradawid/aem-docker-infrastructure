#!/bin/bash
echo "Starting docker proxy"
add-host dispatcher geometrixxselling.com
httpd-foreground
