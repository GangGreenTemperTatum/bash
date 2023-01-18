#!/bin/bash
echo "Hello"

# Welcome! This script is a build script and will copy files for a build deployment from the /source directory to the /build directory
firstline=$(head -n 1 source/changelog.md)

firstline=$(head -n 1 source/changelog.md)
echo $firstline

# Split the string of firstline variable which is gathered from reading the head (1 line only) of changelog.md to an array
read -a splitfirstline <<< $firstline

# Specify a new variable equals to the array but index value of 1
# As a test to print the array:
# echo $splitfirstline

version=${splitfirstline[1]}
# Echo a statement to split

# Provide the user a prompt by informing them of the build version from the changelog.md header
echo "You are building version (from changelog.md)" $version

# Prompt the user for terminal input:
echo 'Do you want to continue? (enter "1" for yes, "0" for no)'

read versioncontinue

# Create a conditional script to verify user input:
if [ $versioncontinue -eq 1 ]
then
echo "OK"
for filename in source/*
do
echo $filename

if [ $filename == "source/secretinfo.md" ]
then
echo "Not copying" $filename
else
echo "Copying" $filename
cp $filename build
fi
done

else
echo "Please come back when you are ready."
fi

# Change directory to destination build directory and verify copied files
cd build

echo "Build version $version contains:"
ls -halt

# Return back to Script location
cd ..
