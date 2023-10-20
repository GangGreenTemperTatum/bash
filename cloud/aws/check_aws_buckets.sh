#!/bin/bash

# Define the input file containing IP addresses or S3 endpoint URLs
input_file="ip_list.txt"

# Define the output file to store the results
output_file="aws_bucket_results.txt"

# Ensure the output file is empty before starting
> "$output_file"

# Loop through each IP address or S3 endpoint URL
while IFS= read -r target; do
  # Use the AWS CLI to list S3 buckets
  aws s3 ls --endpoint-url "https://$target" 2>/dev/null
  if [ $? -eq 0 ]; then
    echo "AWS S3 Bucket found at $target" >> "$output_file"
  fi
done < "$input_file"

echo "AWS S3 bucket scan completed. Results saved to $output_file"
