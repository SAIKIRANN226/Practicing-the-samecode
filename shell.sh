#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

NUMBER=100

if [ $NUMBER -ne 0 ]
then 
    echo -e "$R ERROR:: Given number is greater than 100 $N"
    exit 1
else
    echo -e "$Y Given number is not greater than 100 $N"
fi