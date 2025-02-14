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
        echo -e "$2.....$G....SUCCESS $N"
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

dnf module enable nodejs:18 -y &>> LOGFILE

VALIDATE $? "Enabling nodejs18"

dnf install nodejs -y &>> $LOGFILE

VALIDATE $? "Installing nodejs"

id roboshop
if [ $? -ne 0 ]
then 
    useradd roboshop
    VALIDATE $? "added roboshop user"
else    
    echo -e "$Y Roboshop user already exists so skipping"
fi 

mkdir -p /app

VALIDATE $? "Creating app folder"

cd /app

VALIDATE $? "Moving to the app folder"

curl -L -o /tmp/cart.zip https://roboshop-builds.s3.amazonaws.com/cart.zip &>> $LOGFILE

VALIDATE $? "Downloading the cart application code"

unzip -o /tmp/cart.zip &>> $LOGFILE

VALIDATE $? "Unzipping the cart code"

npm install &>> $LOGFILE

VALIDATE $? "Installing dependencies"

cp /home/centos/Practice/cart.service /etc/systemd/system/cart.service &>> $LOGFILE

VALIDATE $? "Copied cart.service file"

systemctl daemon-reload &>> $LOGFILE

VALIDATE $? "Loading daemon"

systemctl enable cart  

VALIDATE $? "Enabling cart"

systemctl start cart

VALIDATE $? "Starting cart"

