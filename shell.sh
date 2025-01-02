#!/bin/bash

SOURCE_DIR="/tmp/shell-logs"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ ! -d $SOURCE_DIR ]
then 
    echo -e "$R $SOURCE_DIR does not exists $N"
fi 

FILES_TO_DELETE=$(find $SOURCE_DIR -type f -mtime +30 -name ".*log")

