#!/bin/bash

# Variables
username="Jay"
filename=$3

# User Input
read -p "Enter your username: " user
echo "Username: $user"

# Conditional if Statement
if [ "$EUID" -ne 0 ]; then
    echo "You are not running this script as the root user."
else
    echo "You are running this script as the root user."
fi

# For Loop
echo "Counting to 5:"
for i in {1..5}; do
    echo "$i"
done

# Functions
function greet() {
    echo "Hello, $1!"
}
greet "Alice"

# Conditional Case Statement
echo "Enter a number between 1 and 2:"
read num
case $num in
    1) echo "You chose one." ;;
    2) echo "You chose two." ;;
    *) echo "Invalid choice." ;;
esac

# File Operations
if [ -e "$filename" ] && [ -d "$filename" ]; then
    echo "File exists and is a directory."
else
    echo "File does not exist or is not a directory."
fi

# Command Line Arguments
echo "First argument: $1"
echo "Second argument: $2"

# Exit Status Codes
cat nonexistent-file.txt 2> /dev/null
echo "Exit status: $?"

# Indexed Arrays
fruits=("Apple" "Orange" "Banana")
echo "Fruits: ${fruits[0]}"

# Associative Arrays
declare -A capitals
capitals[USA]="Washington D.C."
capitals[France]="Paris"
echo "Capital of France: ${capitals[France]}"

# Command Substitution
current_date=$(date)
echo "Today's date is: $current_date"

# Command Line Redirections
echo "This is a sample text." > example.txt
find / -name hello.txt &> /dev/null

# Arithmetic Operations
result=$(( 10 + 2 ))
echo "$result"

# Parameter Expansion
SRC="/path/to/foo.cpp"
BASEPATH=${SRC%/*}
echo "$BASEPATH"

# Process Signal Handling
trap 'echo "Received SIGTERM signal. Cleaning up..."; exit' SIGTERM

# Comments
# This is a single line comment
: '
This is a 
multiline
comment
'
