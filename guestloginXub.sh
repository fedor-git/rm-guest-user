#!/bin/bash

# prints colored text
print_style () {

	if [ "$2" == "info" ] ; then
		COLOR="96m";
	elif [ "$2" == "success" ] ; then
		COLOR="92m";
	elif [ "$2" == "warning" ] ; then
		COLOR="93m";
	elif [ "$2" == "danger" ] ; then
		COLOR="91m";
	else #default color
		COLOR="0m";
	fi

	STARTCOLOR="\e[$COLOR";
	ENDCOLOR="\e[0m";

	printf "$STARTCOLOR%b$ENDCOLOR" "$1";
}

print_style "----------> Check guest login allowed <----------\n" "info"
if [ ! -f /usr/share/lightdm/lightdm.conf.d/50-no-guest.conf ]; then
 while true; do
	read -p "Disallow guest user login? " yn
	case $yn in
		[Yy]* ) sudo sh -c 'printf "[Seat:*]\nallow-guest=false\n" > /usr/share/lightdm/lightdm.conf.d/50-no-guest.conf'; print_style "\nAll OK!\nBye...\n" "success"; exit;;
		[Nn]* ) print_style "\nNothing to do! \nBye...\n" "success"; exit;;
		* ) print_style "Please answer yes or no.\n" "warning";;
	esac
done
else
 while true; do
    read -p "Allow guest user login? " yn
	case $yn in
	     [Yy]* ) sudo rm /usr/share/lightdm/lightdm.conf.d/50-no-guest.conf; print_style "\nAll OK!\nBye...\n" "success"; exit;;
		 [Nn]* ) print_style "\nNothing to do! \nBye...\n" "success"; exit;;
		 * ) print_style "Please answer yes or no.\n" "warning";;
	esac
done
fi