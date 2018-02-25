#!/bin/bash
host_name=$1
domain=$2
ip=$(host -4 $host_name | grep -E -o '([0-9]{1,3}\.){3}[0-9]{1,3}')
echo "Adding $ip to $domain"
echo "$ip $domain" >> /etc/hosts
