# A simple script to enumerate through files & folders in a directory and compress/zip them using the native zip utility
#!/usr/local/bin/bash

dir=$(ls ./test)
while IFS= read -r line 
do
        zip -r "$line.zip" "$line"
        echo "Zipped Folder: $line at at $(date +"%Y-%m-%d %H:%M:%S")"
done <<< "$dir"
