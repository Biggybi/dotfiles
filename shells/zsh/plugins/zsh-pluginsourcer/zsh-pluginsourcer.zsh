# **************************************************************************** #
#                                                                              #
#                                                                              #
#    zsh-pluginsourcer.zsh                                                     #
#                                                                              #
#    By: biggybi <biggybi@protonmail.com>                                      #
#                                                                              #
#    Created: 2021/10/12 20:01:09 by biggybi                                   #
#    Updated: 2021/10/12 20:01:09 by biggybi                                   #
#                                                                              #
# **************************************************************************** #

function setSourcerPath()
{
	if [ -z "${PLUGINSOURCER_PATH}" ] ; then
		if [ -n "${DOT}" ] ; then
			export PLUGINSOURCER_PATH="$DOT/shells/zsh/plugins"
		else
			export PLUGINSOURCER_PATH="$HOME/.zsh"
		fi
	fi
}

function sourcePlugins()
{
	for plugin in $(ls "$PLUGINSOURCER_PATH") ; do
		if [ "$plugin" != "zsh-pluginsourcer" ] ; then
			myfile=$(find "$PLUGINSOURCER_PATH/$plugin/" -name "$plugin\.zsh")
			if ! [ -n "$myfile" ] ; then
				myfile=$(find "$PLUGINSOURCER_PATH/$plugin/" -name "$plugin\.plugin\.zsh")
			fi
			source "$myfile"
		fi
	done
}

setSourcerPath
sourcePlugins
