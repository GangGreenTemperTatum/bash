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

# Extract unique values from specified column
# Assumes that the column is the specified column name
# Adjust the delimiter if needed (currently set to comma)
unique_values=$(awk -F',' -v column_name="$2" 'NR==1{for(i=1;i<=NF;i++){if($i==column_name){column_number=i;break}}} NR>1{print $column_number}' "$1" | sort -u)

# Count the number of unique values
num_unique_values=$(echo "$unique_values" | wc -l)

# Print all unique values
echo "Unique values for column '$2':"
echo "$unique_values"

# Print the count
echo "Total unique values: $num_unique_values"
