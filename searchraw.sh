#!/bin/bash

########################################################################
# Credits, blame, etc
########################################################################
#	searchraw - a surfraw launcher for openbox

#   Base from openbox_playonlinux_pipemenu by Ryan Fantus
#	https://github.com/ryanfantus/openbox_playonlinux_pipemenu

#	Helpful solutions
#   http://stackoverflow.com/questions/5998066/bash-script-variable-content-as-a-command-to-run
#   http://www.cyberciti.biz/faq/awk-find-and-replace-fields-values/
# 	


########################################################################
# Usage
########################################################################

# Call this script by itself to generate an openbox menu with all elvi
# that are on the system and to search them with a popup text box.
# Call with -d to pop up (optional) few elvi to use, or to use the 
# default, and search with a popup text box.  
# Call with -d and an elvi to pop up a text box to search.

########################################################################
# Requires
########################################################################

# * Surfraw - http://surfraw.alioth.debian.org
# * Openbox (Sort of.  This is way overblown if you're not using OB.)
# * zenity or a replacement like matedialog or wenity.

########################################################################
# Configuration
########################################################################

# Default elvii.  SPECIFY ONE HERE
default_elvii="google"

# Do you want a popup if no elvii are specified?
popup="TRUE"

# What elvii should be presented in the Zenity combobox?  These should
# be in a single line, space separated.
# DO NOT INCLUDE THE DEFAULT ELVII HERE unless you want repeats
custom_elvii="scholar stack github wayback wikipedia"

########################################################################
# Generate list of elvii for OB
########################################################################

function generate_elvi_menu {

sr -elvi | while read; do
		elvi_cmd=$(echo "${REPLY}" | awk '{print $1}')
		# The long description chokes my install of OB
		elvi_dsc=$(echo "${REPLY}" | awk '{print $1}')
		echo -n '<item label="'"$elvi_dsc"'">'
		echo -n '<action name="Execute"><execute>'
		echo -n "$0 -d $elvi_cmd"
		echo '</execute></action>'
		echo '</item>'
	done

}

########################################################################
# Write the Menu				
########################################################################
function write_ob_menu {

echo '<openbox_pipe_menu>'
generate_elvi_menu
echo '</openbox_pipe_menu>'

}

# Are we being launched directly?
if [ "$1" == "-d" ]; then
	# When being launched directly, what elvii should be presented/used?
	if [ "$2" == "" ]; then 
		if [ "$popup" == "TRUE" ]; then
			buildinglist=" $default_elvii $custom_elvii"
			elvii_list=$(echo "$buildinglist" | awk '{ gsub(" "," FALSE "); print }')
			choicecmdline="zenity --timeout 30 --list  --text 'Elvi to use?' --radiolist  --column 'Pick' --column 'Elvi' $elvii_list"
			echo "$choicecmdline"
			read
			elvi=$(eval "$choicecmdline")
#			elvi=$(zenity --timeout 30 --list  --text "Elvi to use?" --radiolist  --column "Pick" --column "Elvi" TRUE google FALSE scholar FALSE stack FALSE github FALSE wayback FALSE wikipedia)
		else
			elvi="$default_elvii"
		fi	
	else
		elvi="$2"
	fi

	szAnswer=$(zenity --entry --title "search" --text "Search what?" --entry-text "") 
	if [ "$szAnswer" != "" ]; then
		sr_command="sr -g $elvi $szAnswer"
		eval "$sr_command"
	fi
else
	write_ob_menu
fi
