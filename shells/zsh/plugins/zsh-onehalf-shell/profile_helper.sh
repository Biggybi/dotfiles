#!/usr/bin/env bash
if [ -s "$BASH" ]; then
    file_name=${BASH_SOURCE[1]}
elif [ -s "$ZSH_NAME" ]; then
    file_name=${(%):-%x}
fi
script_dir=$(cd "$(dirname "$file_name")" && pwd)

. $ONEHALF_PATH"/realpath/realpath.sh"

if [ -f ~/.onehalf-theme ]; then
  script_name=$(basename "$(realpath ~/.onehalf-theme)" .sh)
  echo "export ONEHALFTHEME=${script_name#*-}"
  echo ". ~/.onehalf-theme"
fi
cat <<'FUNC'
_onehalf()
{
  local script=$1
  local theme=$2
  [ -f $script ] && . $script
  ln -fs $script ~/.onehalf-theme
  export ONEHALFTHEME=${theme}
  echo -e "if \0041exists('g:colors_name') || g:colors_name != '$theme'\n  colorscheme onehalf-$theme\nendif" >| ~/.vimrc_background
  if [ -n ${ONEHALFSHELL_HOOKS:+s} ] && [ -d "${ONEHALFSHELL_HOOKS}" ]; then
    for hook in $ONEHALFSHELL_HOOKS/*; do
      [ -f "$hook" ] && [ -x "$hook" ] && "$hook"
    done
  fi
}
FUNC
# PATH+=:$script_dir/scripts
# for script in "$script_dir"/scripts/onehalf*.sh; do
#   script_name=${script##*/}
#   script_name=${script_name%.sh}
#   theme=${script_name#*-}
#   func_name="onehalf-${theme}"
# done;

