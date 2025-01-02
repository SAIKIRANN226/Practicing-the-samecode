#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR="/tmp/shell-logs"

if [ ! -d $SOURCE_DIR ]
then 
    echo -e "$R Source_DIR: $SOURCE_DIR does not exists $N"
    exit 1
fi 

find $SOURCE_DIR -type d -exec rm -rf {} \;