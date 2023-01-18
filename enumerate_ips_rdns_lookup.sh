# A simple script to enumerate a line-separated text file containing IP addresses and perform RDNS lookup using the native `host` command
#!/usr/local/bin/bash

filename="./listofips.txt"

echo Start

while read p; do
    date
    echo "Checking now:" $p
    echo "IP:" $p  >> ./results.txt
    host $p >> ./results.txt
    echo "Next task..."
    echo "---------------------------------------" >> ./results.txt
done < $filename

echo Done!
printf "%(%Y-%m-%d %H:%M:%S)T is %s\n" -1 "Completion Time"
