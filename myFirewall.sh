#!/bin/bash
#Date 2-Apr-2020 by Rahul Sharma
#for more scripts, visit- mrahul001.github.io

#default website list to block
websiteDefault=("www.facebook.com" 
				"www.twitter.com"
				"www.covid19india.org"
				"www.tiktok.com"
				"www.instagram.com" 
				"www.youtube.com" )

#function to list all the websites going to be blocked
websitesList()
{
echo -e "\nyou are going to block below websites::  "

websiteDefault="$1"
for web in "${websiteDefault[@]}"
do
	echo -e $web
done
}

#exit msg
myExit()
{
	echo -e "\n*************************************************************************************"
	echo "********************Ok exiting, GoodBye!! See you soon.******************************"
	echo -e "*************************************************************************************\n"
	exit 0 
}


#function to block websites
blockWebsites()
{
	echo -e "\n***********************************************************************************"
	echo "*********************proceeding to Block websites**********************************"
	echo "***********************************************************************************"
	
	websiteDefault="$1"	

	#access each website as $web. . .
	for web in "${websiteDefault[@]}"
	do
		count=0
		#access each IP of website as $ip. . .
		for ip in $(host ${web} | grep "has address " | cut -d' ' -f4)
		do 
			#echo $ip
			sudo /usr/sbin/iptables -A INPUT -s $ip -p tcp --dport 443 -j DROP
			sudo /usr/sbin/iptables -A INPUT -s $ip -j DROP
			sudo /usr/sbin/iptables -A OUTPUT -p tcp -d $ip --dport 443 -j DROP

			let count++
		done
		#echo $count
		echo "_____________" $web "************BLOCKED*************"
	done
echo -e "\n----------------------Finished Successfully!!!---------------------------------\n"

while true ; do
	read -p "Missed to add a website?? continue:: Y/N    " cont
		case $cont in
			[Yy]* )
				enblChoice
				;;
			[Nn]* ) 
				myExit
				;;
			*)
				echo "Aaaha! Bad Input :( try again !!"
				;;
		esac
done
}

#function to add new websites to block list
addBlockRqst()
{	
	#testing only---when only one input---testing only 
	#echo -e "please enter the complete address of the website to block:: "
	#read usrInpt
	#websiteDefault+=( "$usrInpt")
	#echo -e "\nAdded:: "
	#echo $usrInpt

	#check whether argument passed or not 
	if [ $# -eq 0 ]
  	then
    	echo -e "Only WEBSITEs entered by you will be BLOCKED!!!"
    	unset websiteDefault
    	#when multiple userinputs
		echo -e "Enter the WEBSITE/s to block:: use CTRL+D after done! \n"
		readarray -t web
		# Do something...
		#declare -p arr
		websiteDefault+=( "${web[@]}" )

		#listing websites to block
		websitesList "${websiteDefault[@]}"

		#calling blockWebsite function
		blockWebsites "${websiteDefault[@]}"

    else 
    	websiteDefault="$1"

		#when multiple userinputs
		echo -e "Enter the WEBSITE/s to block:: use CTRL+D after done! \n"
		readarray -t web
		# Do something...
		#declare -p arr
		websiteDefault+=( "${web[@]}" )

		#listing websites to block
		websitesList "${websiteDefault[@]}"

		#calling blockWebsite function
		blockWebsites "${websiteDefault[@]}"
	fi
}

#function to list all the blocked website
listBlockedWeb()
{
	#ask for the user to enter the number associated to the website from above output to block
	#read -p "Select Website to UNBLOCK:: " opt

			#echo "Sorry! No input provided :( "
			#listBlockedWeb
	 
    #when multiple userinputs
	#echo -e "Enter the WEBSITE/s to block:: use CTRL+D after done! \n"
	#readarray -t web
	#declare -p arr  ---for-debugging purpose only!!!

	echo "we are in blocked list"
	exit 0
}

#function used to unblock websites
unBlockWebsites()
{	
	echo -e "\n++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo "-------------->FLUSH ALL RULES<------------------Enter 'F/f/FLUSH/Flush/flush' "
	echo "-------------->UNBLOCK a selected Website<-------Enter 'S/s/SELECT/Select/select'"
	echo "-------------->EXIT<-----------------------------Enter 'E/e/Exit/exit/EXIT'    "
	echo -e "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	read -p "So what u have decided? " disblChoice

		case $disblChoice in
			[Ff]* )
				sudo /usr/sbin/iptables -F
				echo -e "\n----------------------FLUSHED ENTIRE IPTABLES---------------------------------\n"
				;;

			[Ss]* )
				unset web
				echo -e "Below is the list of BLOCKED websites::-"
				##call list blocked website function here
				listBlockedWeb
				;;

			[Ee]* )
				myExit 
				;;

			*)
				echo "Aaaha! Bad Input :( "
				;;
		esac
}

#this function lets you choose default list or
# allows to modify website list to block/unblock 
enblChoice()
{	
	echo -e "\n+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	echo "------------->DEFAULT Block<-----------------Enter 'D/d/DEFAULT/Default/default' "
	echo "------------->DEFAULT + USER Defined<--------Enter 'M/m/More/MORE/more' "
	echo "------------->USER Defined only<-------------Enter 'S/s/Self/SELF/Self' "
	echo "------------->EXIT<--------------------------Enter 'E/e/Exit/exit/EXIT'    "
	echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	read -p "Enter you choice::   " usrRspns
		
		#case run to work according to the user choice
		case $usrRspns in
		 	[Dd]* )
				echo -e "You are proceeding with default LIST:: "
				
				#uncomment websitesList to see deafult list
				websitesList "${websiteDefault[@]}"

				#call for block function below

				#change 1
				blockWebsites "${websiteDefault[@]}"
				;;

			[Mm]* )
			 	addBlockRqst "${websiteDefault[@]}"
			 	;;

			[Ss]* ) 
				addBlockRqst
				;;

			[Ee]* )
				myExit 
				;;

			*) 
				echo "Aaahaa!! Choose wisely again :) "
				enblChoice
				;;

		esac
}

#this is the main function 
startFirewall()
{

echo -e "\n+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo "-------------->BLOCK a Website<-----------Enter 'B/b/Block/block/BLOCK'  "
echo "-------------->UNBLOCK a Website<---------Enter 'U/u/UNBLOCK/unblock/Unblock'  "
echo "-------------->EXIT<----------------------Enter 'E/e/Exit/exit/EXIT'    "
echo "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
read -p "Enter your Choice:: " ops
#echo -e "\n"

case $ops in 
	[Bb]* ) 		
		#prompt block options
		enblChoice
		;;

	[Uu]* )
		echo -e "\n*************************************************************************************"
		echo "----------------------------->UNBLOCK WEBSITES!!!<--------------------------------"
		echo -e "*************************************************************************************"
		unBlockWebsites
		;;

	[Ee]* )
		myExit 
		;;

	*) 
		echo -e "\nInvalid Choice :( "
		startFirewall
		;;    
esac
}
echo "**********************************************************************************************************"
echo "******************************************MY FIREWALL*****************************************************"
echo "**********************************************************************************************************"
startFirewall