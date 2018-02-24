#!/bin/bash
tmp=1
while true
do
echo "this script is running: $tmp " 
echo "running serverStatus.php"
/usr/bin/php serverStatus.php
((tmp++))
#sleep 2m
done
