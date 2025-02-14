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
        echo -e "$2.....$R...FAILED $N"
        exit 1
    else
        echo -e "$2.....$G...SUCCESS $N"
    fi 
}

if [ $ID -ne 0 ]
then 
    echo -e "$R ERROR:: Please run the script with root user $N"
    exit 1
else
    echo -e "$Y Script started executing at $DATE $N"
fi 

dnf module disable mysql -y &>> $LOGFILE

VALIDATE $? "Disabling old mysql"

cp mysql.repo /etc/yum.repos.d/mysql.repo &>> $LOGFILE

VALIDATE $? "Copied mysql.repo file"

dnf install mysql-community-server -y &>> $LOGFILE

VALIDATE $? "Installing mysql-community-server"

systemctl enable mysqld

VALIDATE $? "Enabling mysqld"

systemctl start mysqld

VALIDATE $? "Starting mysqld"

mysql_secure_installation --set-root-pass RoboShop@1 &>> $LOGFILE

VALIDATE $? "Changing roboshop password"

systemctl restart mysql

VALIDATE $? "Restarting mysql"