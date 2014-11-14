surfraw_ob
==========

searchraw - a surfraw launcher for openbox

I like [surfraw](http://surfraw.alioth.debian.org/).  It's a command line tool that helps you search the web quite well - but I often *forget* exactly how much power and utility is there.  And since I'm usually in a graphical environment, I waste time running about and not using this amazing tool.

Add to that fact that there are a **TON** of helpers (or elvi) - full list [here](http://surfraw.alioth.debian.org/#usage) - and I frequently forgot when there would be a useful one.


## Credits, blame, etc

*	By Steven Saus, licensed under the MIT license
*   [Base from openbox_playonlinux_pipemenu by Ryan Fantus](https://github.com/ryanfantus/openbox_playonlinux_pipemenu)



## Usage

* Call this script by itself to generate an openbox menu with all elvi that are on the system and to search them with a popup text box.
* Call with -d to pop up (optional) few elvi to use, or to use the default, and search with a popup text box.  
* Call with -d and an elvi to pop up a text box to search.

## Requires


* [Openbox](http://openbox.org/wiki/Main_Page) (Sort of.  This is way overblown if you're not using OB.)
* [surfraw](http://surfraw.alioth.debian.org)

* [zenity](https://help.gnome.org/users/zenity/stable/) or a replacement like [matedialog](https://github.com/mate-desktop/mate-dialogs) or [wenity](http://freecode.com/projects/wenity).

# Configuration

There are three variables that need to be changed in the script.  Sane defaults are provided (as in the example below).

* Default elvii.
`	default_elvii="google"

* Do you want a popup if no elvii are specified?
` popup="TRUE"

* What elvii should be presented in the Zenity combobox?  These should be in a single line, space separated. DO NOT INCLUDE THE DEFAULT ELVII HERE unless you want repeats.
` custom_elvii="scholar stack github wayback wikipedia"

# Openbox Configuration

Obviously, edit the path names as appropriate.

		<item label="search"><action name="execute"><execute>/home/USERNAME/scripts/openbox/searchraw -d</execute></action></item>
		<menu execute="/home/USERNAME/scripts/openbox/searchraw" id="searchraw" label="searchraw"/>			

