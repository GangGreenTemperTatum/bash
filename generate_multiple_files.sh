# This Bash Script will create filenames using numbers and take an argument in the running of the script
#!/bin/bash

if [ "$1" = "" ]; then
  echo "Usage: $0 <number of files to create>"
  exit 1
fi

now=`date '+%Y-%m-%d_%H%M%S'`
prefix="${now}_myFilePrefix"
echo "creating $1 files"
echo "now=$now"

for i in $(seq 1 $1); do file="${prefix}_${i}.log"; echo "creating $file"; touch $file; done

# To execute it (create 100 files for example)
# $ chmod +x for-create-multiple-files.sh
# $ ./for-create-multiple-files.sh 100
