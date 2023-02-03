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

[ -n "${PLUGINSOURCER_PATH}" ] && pluginInstallDir="${PLUGINSOURCER_PATH}"\
	|| [ -n "${DOT}" ] && pluginInstallDir="$DOT/shells/zsh/plugins"\
	|| pluginInstallDir="$HOME/.zsh"

pluginsFolders=$(find $pluginInstallDir -mindepth 1 -maxdepth 1\
	! -name "zsh-pluginsourcer" -printf '%f\n')

echo $pluginsFolders | while read plugin; do
	source $(find "$pluginInstallDir/$plugin/" -name "$plugin.*.zsh")
done

unset plugin
unset pluginInstallDir
unset pluginsFolders
