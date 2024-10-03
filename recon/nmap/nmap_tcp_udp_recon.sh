#!/bin/bash

# Define the input and output file names
input_file="ip_list.txt"
output_file="nmap_results.txt"

# Ensure the output file is empty before running Nmap
> "$output_file"

# Loop through each IP address in the input file
while IFS= read -r ip; do
  # Run Nmap to enumerate all TCP ports
  nmap -p- -T4 -oG - "$ip" | grep "Ports:" >> "$output_file"

  # Run Nmap to enumerate all UDP ports
  nmap -sU -p- -T4 -oG - "$ip" | grep "Ports:" >> "$output_file"

done < "$input_file"

echo "Nmap scan completed. Results saved to $output_file"
