#!/bin/bash 
#this script will iterate through DB dump and 
#will create seperate dump for table 
#desired to restore
tblStart=( A E M )
trackerId=(  014714 009484   
 002514   
 043921   
 042305   
 007717   
 003655   
 012596   
 992019   
 988918   
 987337   
 981265   
 946586   
 931509   
 924886   
 923170   
 910838   
 909196   
 906157   
 887386   
 879683   
 873473   
 859328   
 854260   
 849313   
 847147   
 842310   
 826498   
 823865   
 795909   
 783751   
 756197   
 748114   
 741577   
 740346   
 738722   
 722609   
 709184   
 705666   
 705378   
 699260   
 689949   
 684840   
 679717   
 675599   
 656897   
 651978   
 643525   
 643064   
 640968   
 625856   
 602876   
 598719   
 510847   
 499207   
 491952   
 490862   
 487653   
 472165   
 466615   
 452493   
 445737   
 438798   
 430148   
 424807   
 420598   
 404938   
 385446   
 365144   
 355669   
 352287   
 333771   
 329703   
 317486   
 311330   
 275176   
 274250   
 270865   
 264280   
 254618   
 249779   
 235809   
 232595   
 230084   
 228116   
 204044   
 200501   
 192914   
 186660   
 170841   
 167114   
 152873   
 149623   
 143704   
 143249   
 131223   
 124948   
 116946   
 116185   
 041093 )   
for tStart in "${tblStart[@]}"
do
   echo $tStart
   for tId in "${trackerId[@]}"
   do 
   tableName=$tStart$tId
   echo $tableName 
#  sed -n -e '/CREATE TABLE.*`$tableName`/,/CREATE TABLE/p' mysql.dump > $tableName.sqlmysql
   mysql -u root -pembarc fnsv4 < $tableName.sql
  done
done
