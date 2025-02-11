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
        echo -e "$2....$R....FAILED $N"
        exit 1
    else
        echo -e "$2....$G....SUCCESS $N"
    fi 
}

if [ $ID -ne 0 ]
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

VALIDATE $? "Install nodejs"

id roboshop
if [ $? -ne 0 ]
then 
    useradd roboshop
    VALIDATE $? "Adding roboshop user"
else
    echo -e "User already exists so....$Y SKIPPING $N"
fi 

mkdir -p /app

VALIDATE $? "Creating app folder"

cd /app 

VALIDATE $? "Moving to the app folder"

curl -L -o /tmp/user.zip https://roboshop-builds.s3.amazonaws.com/user.zip

VALIDATE $? "Downloading the code"

unzip -o /tmp/user.zip

VALIDATE $? "Unzipping the code"

npm install 

VALIDATE $? "Installing dependencies"

cp /home/centos/Practice/user.service /etc/systemd/system/user.service

VALIDATE $? "Copied user.service"

systemctl daemon-reload

VALIDATE $? "Loading the daemon"

systemctl enable user 

VALIDATE $? "Enabling user"

systemctl start user

VALIDATE $? "Starting user"

cp /home/centos/Practice/mongo.repo /etc/yum.repos.d/mongo.repo

VALIDATE $? "Copied mongod.repo file"

dnf install mongodb-org-shell -y

VALIDATE $? "Installing mongo-org-sell"

mongo --host 54.166.195.98 </app/schema/user.js

VALIDATE $? "Loading schema"

systemctl restart user

VALIDATE $? "Restarted user"

