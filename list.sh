#!/bin/bash


echo "Hello, what is your name?"
#take user input for thier name
read name
echo "Hello $name, nice to meet you!"
echo ""

#This next part gets the directory to enumerate from either the -
#command arument, or from user input.  Defaults to command variable.

echo "This script gets a count of the files in a directory."
if [ $1 ] 
then
   dir=$1
else
    echo "What directory do you want to enumerate?"
    read dir
fi
count=$(ls $dir | wc -l)
echo $count
echo "Would you like to get a count of all subdirectories also?"
echo "Type y or n"

read -p "y/n >" choice

if [ choice==y ]
then
    echo "Results may be inaccurate without Admin rights"
    dirout=$(ls -R $dir 2>/dev/null | wc -l)
    echo $dirout
else
    echo "Shutting down..."
fi

echo "Would you like to add the listing of another directory?"
read -p "y/n >" choice2

if [ choice2==y ]
then 
    echo "What directory would you like to add?"
    read dir2
    dirout2=$(ls $dir2 | wc -l)
    sum=$(( $dirout + $dirout2 ))
    echo "the sum is $sum"
else
    echo "Good Bye!"
fi
