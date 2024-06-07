#!/bin/bash

# Check if filename argument is provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <filename.csv> <column_name>"
    exit 1
fi

# Check if the file exists
if [ ! -f "$1" ]; then
    echo "File '$1' not found."
    exit 1
fi

# Extract unique values from column "httpRequest.remoteIp"
# Assumes that the column is the specified column name
# Adjust the delimiter if needed (currently set to comma)
unique_ips=$(awk -F',' -v column_name="$2" 'NR==1{for(i=1;i<=NF;i++){if($i==column_name){column_number=i;break}}} NR>1{print $column_number}' "$1" | sort -u)

# Count the number of unique IPs
num_unique_ips=$(echo "$unique_ips" | wc -l)

# Print the count
echo "Total unique IPs: $num_unique_ips"
