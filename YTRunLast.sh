#!/bin/bash
IFS=$'\n'
cat=$(cat playlists)
lineno=1
for line in $cat;
do
thisline=$(head -$lineno playlists | tail -1)
echo $thisline
lastdate=${thisline%% *}
today=$(date +%Y%m%d)
if [ "$lastdate" != "$today" ]
then
	playlist=${thisline##* }
	sed -i "$lineno"'s/......../'"$today"'/' playlists
	youtube-dl -i --dateafter $lastdate --datebefore now-1day -f 140 -o #DIRECTORY-AND-OPTIONS $playlist
fi
lineno=$((lineno+1))
done


