# Setup fzf
# ---------
if [[ ! "$PATH" == *$DOT/vim/pack/bundle/start/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}$DOT/vim/pack/bundle/start/fzf/bin"
fi

# Auto-completion
# ---------------
# [[ $- == *i* ]] && source "$DOT/vim/bundle/fzf/shell/completion.bash" 2> /dev/null
[[ $- == *i* ]] && source "$DOT/vim/pack/bundle/start/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
# [[ $- == *i* ]] && source "$DOT/vim/bundle/fzf/shell/key-bindings.bash" 2> /dev/null
[[ $- == *i* ]] && source "$DOT/vim/pack/bundle/start/fzf/shell/key-bindings.bash" 2> /dev/null
