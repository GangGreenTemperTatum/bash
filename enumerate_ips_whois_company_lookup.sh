#!/bin/bash
for ip in $(cat ./ip-list.txt)
do whois $ip | grep "Company A" > /dev/null
    if [ $? -eq 0 ]
        then echo “$ip”
    fi
done
