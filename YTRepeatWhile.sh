#!/bin/bash
y=0
var2=0
var3=""
youtube-dl -f 140 --max-filesize 14M --playlist-start 2 -o '/home/Your_Download_Folder-%(title)s' https://www.youtube.com/playlist?list=Your_Youtube_Playlist
#Downloads the 1st two which might have been uploaded since last run.
while !   #Infinite loop
		var=$(find /home/Your_Download_Folder -type f -printf x | wc -c)
		#Gets number of files previously downloaded by counting in destination folder.
		if [ "$var2" = "$var3" ]
			then inc=$((inc+1))
		fi
		#Checks previous 2 counts to allow youtube-dl to skip an error/try the file once more.
		var=$((var+inc))
		#inc represents the number of files that were already skipped
		if [ "$y" == 1 ] #Alternates between changing var2 and var3 which allows youtube-dl to
				 #try a single file twice. This tolerates both kinds of errors, some
				 #can be accessed on try 2 but others must be skipped.
			then 
			y=0
			var2=$((var))
			else
			y=1
			var3=$((var))
		fi
			read -t 2 -p "var override?" x
		fi
		#Provides option to user to decide where to start.
		if [ "$x" = "Y" ] || [ "$x" = "Yes" ]
			then
			read -p "What number should playlist start at?" var
		fi
youtube-dl -f 140 --max-filesize 14M --playlist-start $var -o '/home/Your_Download_Folder-%(title)s' https://www.youtube.com/playlist?list=Your_Youtube_Playlist -c --socket-timeout 5
sleep 5 #this was needed - loop would exit before YTDL was stopped
do echo DISCONNECTED
done
