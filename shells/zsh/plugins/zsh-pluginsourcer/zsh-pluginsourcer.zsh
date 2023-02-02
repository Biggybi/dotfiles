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

getPluginMainDir()
{
	[ -n "${PLUGINSOURCER_PATH}" ] && local plugpath="${PLUGINSOURCER_PATH}"\
		|| [ -n "${DOT}" ] && local plugpath="$DOT/shells/zsh/plugins"\
		|| local plugpath="$HOME/.zsh"
	echo "$plugpath"
}

getPluginsDirs()
{
	echo $(find $plugpath -mindepth 1 -maxdepth 1\
		! -name "zsh-pluginsourcer" -printf '%f\n')
}

function sourcePlugins()
{
	local plugpath=$(getPluginMainDir)
	for plugin in $(getPluginsDirs); do
			local myfile=$(find "$plugpath/$plugin/" -name "$plugin\.zsh")
			echo $myfile
			if ! [ -n "$myfile" ] ; then
				local myfile=$(find "$plugpath/$plugin/" -name "$plugin\.plugin\.zsh")
			fi
			source "$myfile"
		done
	}

sourcePlugins
