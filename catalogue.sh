#!/bin/bash

ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

DATE=$(date)

VALIDATE() {
    if [ $1 -ne 0 ]
    then 
        echo -e "$2....$R FAILED $N"
        exit 1
    else
        echo -e "$2....$G SUCCESS $N"
    fi
}

if [ $ID -ne 0]
then 
    echo -e "$R ERROR:: Please run the script with root user $N"
    exit 1
else
    echo -e "$Y Script started executing at $DATE $N"
fi 

dnf module disable nodejs -y 

VALIDATE $? "Disabling old nodejs"

dnf module enable nodejs:18 -y

VALIDATE $? "Enabling nodejs18"

dnf install nodejs -y

VALIDATE $? "Installing nodejs"

id roboshop
if [ $? -ne 0 ]
then 
    useradd roboshop
    VALIDATE $? "Adding user for roboshop"
else
    echo -e "$Y roboshop user already exists so.....SKIPPING $N"
fi 

mkdir -p /app

VALIDATE $? "Creating app folder"

mv /app 

VALIDATE $? "Moving to the app folder"

curl -o /tmp/catalogue.zip https://roboshop-builds.s3.amazonaws.com/catalogue.zip

VALIDATE $? "Downloading code to the app folder"

unzip -o /tmp/catalogue.zip

VALIDATE $? "Unzipping the code"

npm install 

VALIDATE $? "npm installing"

systemctl daemon-reload

VALIDATE $? "Daemon reload"

cp /home/centos/Practice/catalogue.service /etc/systemd/system/catalogue.service

VALIDATE $? "Copied catalogue.service file"

systemctl enable catalogue

VALIDATE $? "Enavling catalogue"

systemctl start catalogue

VALIDATE $? "Starting catalogue"

cp /home/centos/Practice/mongo.repo /etc/yum.repos.d/mongo.repo

VALIDATE $? "Copied mongo.repo"

dnf install mongodb-org-shell -y

VALIDATE $? "Installing mongodb-org-shell"

mongo --host MONGODB-SERVER-IPADDRESS </app/schema/catalogue.js

VALIDATE $? "Loading schema"

systemctl restart catalogue

VALIDATE $? "Restarting catalogue"

