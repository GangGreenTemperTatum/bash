#!/usr/local/bin/bash
filename="./listofips.txt"

echo Start
while read p; do
    echo "Checking now:" $p
    echo "IP: " $p >> ./results.txt
    nslookup $p | grep "Address" >> ./results.txt
    host $p >> ./results.txt
    whois $p | grep "OrgName" -A 3
    echo "Next task..."
    echo "---------------------------------------" >> ./results.txt
done < $filename
echo Done!
printf "%(%Y-%m-%d %H:%M:%S)T is %s\n" -1 "Report Completion Time"
