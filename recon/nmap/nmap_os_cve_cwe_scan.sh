#!/bin/bash
# This script relies on nmap-vulners (https://github.com/vulnersCom/nmap-vulners) as a pre-req
# pip install nmap-vulners

# Define the input file containing IP addresses
input_file="ip_list.txt"

# Create an output directory
output_dir="nmap_results"
mkdir -p "$output_dir"

# Loop through each IP address in the input file
while IFS= read -r ip; do
  # Scan the IP address for OS detection
  nmap -O -oA "$output_dir/os_scan_$ip" "$ip"

  # Scan the IP address for common CVEs using nmap-vulners
  nmap --script vulners -oA "$output_dir/cve_scan_$ip" "$ip"

  # Scan the IP address for common CWEs using nmap-scripts
  nmap --script http-csrf.nse,http-slowloris.nse -oA "$output_dir/cwe_scan_$ip" "$ip"

done < "$input_file"

echo "Nmap scans completed. Results saved to $output_dir"
