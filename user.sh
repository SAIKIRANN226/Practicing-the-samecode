#!/bin/bash

ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
DATE=$(date)

LOGFILE="/tmp/$0-$DATE.log"

VALIDATE() {
    if [ $1 -ne 0 ]
    then 
        echo -e "$2....$R....FAILED $N"
        exit 1
    else
        echo -e"$2.....$G....SUCCESS $N"
    fi 
}

if [ $ID -ne 0 ]
then 
    echo -e "$R ERROR::Please run the script with root user $N"
    exit 1
else
    echo -e "$Y Script started executing at $DATE $N"
fi 

dnf module disable nodejs -y &>> $LOGFILE

VALIDATE $? "Disabling old nodejs"

dnf module enable nodejs:18 -y &>> $LOGFILE

VALIDATE $? "Enabling nodejs18"

dnf install nodejs -y &>> $LOGFILE

VALIDATE $? "Installing nodejs"

id roboshop
if [ $? -ne 0 ]
then 
    useradd roboshop
    VALIDATE $? "Creation of roboshop user"
else
    echo -e "$Y Roboshop user already exists so skipping"
fi 

mkdir -p /app

VALIDATE $? "Creating app folder"

cd /app 

VALIDATE $? "Moving to the app folder"

curl -L -o /tmp/user.zip https://roboshop-builds.s3.amazonaws.com/user.zip &>> $LOGFILE

VALIDATE $? "Downloading application code"

unzip /tmp/user.zip &>> $LOGFILE

VALIDATE $? "Unzipping the code"

npm install &>> $LOGFILE

VALIDATE $? "Installing dependencies"

cp /home/centos/Practice/user.service /etc/systemd/system/user.service &>> $LOGFILE

VALIDATE $? "Copied user.service file"

systemctl daemon-reload &>> $LOGFILE

VALIDATE $? "Loaded the schema"

systemctl enable user 

VALIDATE $? "Enabling user"

systemctl start user

VALIDATE $? "Starting user"

cp /home/centos/Practice/mongo.repo /etc/yum.repos.d/mongo.repo &>> $LOGFILE

VALIDATE $? "Copied mongo.repo"

dnf install mongodb-org-shell -y &>> $LOGFILE

VALIDATE $? "Installing mongodb shell"

mongo --host 172.31.38.42 </app/schema/user.js &>> $LOGFILE

VALIDATE $? "Loading schema"

systemctl restart user

VALIDATE $? "Restarting user"

