#!/bin/bash

LOGS_FOLDER="/var/log/expense-shell"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"
mkdir -p $LOGS_FOLDER

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

VALIDATE()
{
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is....$R FAILED $N" | tee -a $LOG_FILE
    else
        echo -e "$2 is.....$G SUCCESSFULL $N "  | tee -a $LOG_FILE
    fi
}

CHECK_ROOT()
{
    if [ $USERID -ne 0 ]
    then 
        echo -e "$R Please run this script with root priveleges $N" | tee -a $LOG_FILE
        exit 1
    fi
}

echo "$0 script started executing at $(date)"

CHECK_ROOT

dnf module disable nodejs -y
VALIDATE $? "disables nodejs"

dnf module enable nodejs:20 -y
VALIDATE $? "enable nodejs:20"

dnf install nodejs -y
VALIDATE $? "install nodejs"


