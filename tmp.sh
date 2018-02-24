#!/bin/bash
#this script takes the stopped process as the parameter 
#and starts them as the match found 
#we are going to use case statement for the same 
FINDNSECURE_DIR="/root/findnsecure"
LOG_DIR="/var/log"
#enter your server name below
server_name=""
email() {
/usr/bin/sendemail -f urgentalerts@findnsecure.com -t anupam@findnsecure.com -cc rahul.sharma@findnsecure.com -cc ashutosh.singh@findnsecure.com -cc vivek@findnsecure.com -cc manindar.singh@findnsecure.com -u "URGENT!!  $server_name" -m "process $1 not running on server $server_name" -s smtp.elasticemail.com -o tls=yes -xu urgentalerts@findnsecure.com -xp c6b5d7d1-a308-4424-81b7-41fae0fbff12
}
case $1 in
"mysql")
sudo service mysql start 
email $1
;;
"mongo")
email $1 
;;
"udp") 
email $1
;;
"frontend")
email $1 
;;
"mailer" )
email $1 
;;
"geofence" ) 
email $1 
;;
"rfidman" )
email $1 
;;
"ATRX_d" )
email $1 
;;
esac
