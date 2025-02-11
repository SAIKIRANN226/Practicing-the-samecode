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
        echo -e "$2...$R...FAILED $N"
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

dnf install nginx -y

VALIDATE $? "Installing nginx"

systemctl enable nginx

VALIDATE $? "Enabling nginx"

systemctl start nginx

VALIDATE $? "Starting nginx"

rm -rf /usr/share/nginx/html/*

VALIDATE $? "Removing default content"

curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip

VALIDATE $? "Downloading the front end content"

cd /usr/share/nginx/html

VALIDATE $? "Extracting the front end content"

unzip /tmp/web.zip 

VALIDATE $? "Unzipping the code"

cp cp /home/centos/Practice/roboshop.conf /etc/nginx/default.d/roboshop.conf

VALIDATE $? "Copied roboshop.conf"

systemctl restart nginx 

VALIDATE $? "Restarted nginx"