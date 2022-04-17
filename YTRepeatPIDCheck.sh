#!/bin/bash

youtube-dl --playlist-end 2 -o '/home/Your_Download_Folder-%(title)s' https://www.youtube.com/playlist?list=Your_Youtube_Playlist
#YTDL is set so that you can get the 1st 2 videos in case you run this everyday and they do upload daily. 
var=$(find /home/Your_Download_Folder -type f -printf x | wc -c) #sets the playlist-start variable as number in that folder downloaded already.
inc=0
var2=""
var3=""
y=1
while :
do
	ps -C youtube-dl #Checks if youtube-dl has a PID and is running.
	if [[ $? != 0 ]] #If the exit code from PID check isn't 0, then youtube-dl is not running.
		then     #This starts the youtube-dl process again, with an altered starting point
			  #to either skip the error or try it again once.
		var=$(find /home/Your_Download_Folder -type f -printf x | wc -c)
		echo var is $var
		echo var2 is $var2
		echo var3 is $var3
		if [[ $var2 = $var && $var3 = $var ]]
		then inc=$((inc+1))
		fi
		var=$((var+inc))
		echo var+inc is $var
		if [ "$y" == 1 ]; 
		#alternates between var2 and var3 so that YTDL will attempt each video twice before 		moving onto the next video
		then 
			y=0
			var2=$((var))
		else
			y=1
			var3=$((var))
		fi
		echo var is $var
		echo var2 is $var2
		echo var3 is $var3
		read -t 4 -p "var override?" x
		#provides an option to manually input a starting point
		fi
		if [ "$x" = "Y" ] || [ "$x" = "Yes" ]
			then
			read -p "What number should playlist start at?" var
		fi
youtube-dl -f 140 --max-filesize 14M --playlist-start $var -o '/home/Your_Download_Folder-%(title)s' https://www.youtube.com/playlist?list=Your_Youtube_Playlist
done
