# A simple script to enumerate through zipped files & folders in a directory and uncompress/unzip them using the native zip utility
# [Use Case](Wireshark Profiles - See my Repo!)
#!/usr/local/bin/bash

dir=$(ls ./)
while IFS= read -r line 
do
        unzip -r "$line.zip" "$line"
        echo "Unzipped Folder: $line at at $(date +"%Y-%m-%d %H:%M:%S")" >> ./enumerate_zipped_directories_to_unzipped_format.log
done <<< "$dir"
