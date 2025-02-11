#!/bin/bash

ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
DATE=$(date)

VALIDATE() {
    if [ $? -ne 0 ]
    then 
        echo -e "$2....$R FAILED $N"
        exit 1
    else
        echo -e "$2....$G SUCCESS $N"
    fi 
}

if [ $ID -ne 0 ]
then 
    echo -e "$R ERROR:: Please run the script with root user $N"
    exit 1
else
    echo -e "$Y Script started executing at $DATE $N"
fi


cp mongo.repo /etc/yum.repos.d/mongo.repo

VALIDATE $? "Copied mongo.repo"

dnf install mongodb-org -y 

VALIDATE $? "Installing mongodb-org"

systemctl enable mongod

VALIDATE $? "Enabling mongod"

systemctl start mongod

VALIDATE $? "Starting mongod"

sudo sed -i 's/^bindIp: 127.0.0.1/bindIp: 0.0.0.0/' /etc/mongod.conf

VALIDATE $? "Enabling remote connection"

systemctl restart mongod

VALIDATE $? "Restart mongod"