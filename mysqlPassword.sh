#!/bin/bash

read -p "please make sure mysql server is running: Y/N ???  " yn
MyDB=mysql
changePass_mysql() 
{
	    echo ""
	    echo "enter your current mysql root password::  "
	    read -s oldPass
	    echo "enter New password::  "
	    read -s newPass1
	    echo "Varify New password::  "
	    read -s newPass2
        if [ $newPass1 == $newPass2 ]; then 
	 	    mysql -u root -p$oldPass $MyDB -se " set @newPass='${newPass1}' ; update user set password=PASSWORD(@newPass) where User='root' ; flush privileges; " 
			[ $? -eq 0 ] && echo "****************mysql password is changed successfully!!************" || echo "password not changed, check error in mysql Query"
			echo ""
			echo ""
		else
			echo "password didn't match!!!!"
			echo "try again!!!"
			changePass_mysql 
		fi

		echo "re-starting mysql server !!"
        sudo service mysql restart 
		exit 0
}

case $yn in

	[Yy]* )
	    changePass_mysql ;;

[Nn]* )
		echo "starting mysql server!!"
		sudo service mysql start 
		echo ""
        changePass_mysql ;;
esac
