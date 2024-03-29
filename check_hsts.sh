#!/bin/bash

file_path="host_list.txt"  # Change this to the path of your file

while IFS= read -r host; do
    url="https://$host"
    response_headers=$(curl -sI "$url")

    if grep -q -i "Strict-Transport-Security" <<< "$response_headers"; then
        echo "$host has HSTS header."
    else
        echo "$host does not have HSTS header."
    fi
done < "$file_path"

# alternate: $ while IFS= read -r host; do curl -s -vv "$host" 2>&1 | grep -i "Strict" && echo "$host has HSTS header." || echo "$host does not have HSTS header."; done < "host_list.txt"
