#!/bin/bash
tmp=1
#enter your server name below
server_name=""
echo "running apache error log deletion script!!!"
while true
echo "Waiting for file to become larger than 100MB: $tmp "
do 
cd /var/log/apache2/
file_size=$( stat -c %s error.log )
if [ $file_size -gt 104857600 ]; then 
rm error.log
echo "removed apache error log file!!"
touch error.log
echo "created empty log file!!"
sudo service apache2 restart
echo "restarted apache web server"
fi
((tmp++))
sleep 2m
done
