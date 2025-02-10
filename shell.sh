#!/bin/bash

ID=$(id -u)
DATE=$(date)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


if [ $ID -ne 0 ]
then 
    echo -e "$R ERROR:: Please run the script with root user $N"
    exit 1
else
    echo -e "$Y Script started executing at $DATE $N"
fi

yum install mysql -y &>> /tmp/sai.txt

if [ $? -ne 0 ]
then 
    echo -e "$R ERROR:: Installing mysql failed $N"
    exit 123
else
    echo -e "Installing mysql is....$G SUCCESS $N"
fi

yum install git -y &>> /tmp/sai.txt

if [ $? -ne 0 ]
then 
    echo -e "$R ERROR:: Installing git is failed $N"
    exit 1
else
    echo -e "Installing git is....$G SUCCESS $N"
fi