#!/bin/bash

ID=(id -u)
R="\e[31"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
DATE=$(date)

if [ $ID -ne 0 ]
then 
    echo -e "$R ERROR:: Please run the script with root user $N"
    exit 120
else
    echo -e "$Y Script started executing at $DATE $N"
fi

yum install mysql -y 

if [ $? -ne 0 ]
then 
    echo -e "$R ERROR:: Installing mysql failed $N"
    exit 123
else
    echo -e "$Y Installing mysql SUCCESS $N"
fi