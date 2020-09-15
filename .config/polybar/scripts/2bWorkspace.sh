#!/bin/sh

#focused=(' ' ' ' ' ' ' ')
#unfocused=(' ' ' ' '' '' )

focused=' '
unfocused=' '
dev=''
rice=' '
reddit=''
twitch=''


ws=$(( $(xprop -root _NET_CURRENT_DESKTOP | sed -e 's/_NET_CURRENT_DESKTOP(CARDINAL) = //') + 1))

draw(){
	for i in {1..5}; do
		if [[ $i -eq $ws ]]
		then
			echo -ne "$focused "
		else
			echo -ne "$unfocused " 
		fi
	done
}

draw
