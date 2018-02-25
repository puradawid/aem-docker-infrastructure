#!/bin/bash
echo "Starting docker proxy"
add-host dispatcher geometrixxseliing.com
httpd-foreground
