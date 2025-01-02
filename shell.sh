#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR="/tmp/shell-logs"

if [ ! -d $SOURCE_DIR ]
then 
    echo -e "$R SourceDIR: $SOURCE_DIR does not exists $N"
fi 

FILES_TO_DELETE=$(find $SOURCE_DIR -type d -mtime +30)

while IFS= read -r line
do
    echo -e "$Y Deleting files $line"
    rm -rf $line
done <<< $FILES_TO_DELETE