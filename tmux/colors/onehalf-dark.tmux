#!/bin/tmux

bk="#282c34"
rd="#e06c75"
gn="#98c379"
yw="#e5c07b"
be="#61afef"
pe="#c678dd"
ma="#ef61af"
we="#dcdfe4"

g1="#313640"
g2="#373C45"
g3="#474e5d"
g4="#5c6370"
g5="#919baa"

fg=${we}
bg=${bk}

set -g status-left '#{?client_prefix,#[fg='$yw' bg='$g1'],#[fg='$g3' bg=#'$g1']}#{?client_prefix,#[fg='$bg' bg='$yw'],#[fg='$fg' bg=#'$g3']} #S#{?client_prefix,#[fg='$yw' bg='$g1'],#[fg='$g3' bg=#'$g1']}'
set -g window-style fg="$fg,"bg="$bg"
set -g window-active-style fg="$fg,"bg="$bg"
set -g status-style fg="$fg,"bg="$bg"
set -g window-status-style fg="$g5,"bg="$bg"
set -g window-status-current-format '#{?window_zoomed_flag,#[fg=#'$yw' bg=#'$bg'],#[fg='$fg' bg=#'$bg']} #I #W'
set -g window-status-current-style fg="$fg,"bg="$bg"
set -g pane-active-border-style fg="$g5,"bg="$bg"
set -g pane-border-style fg="$g3,"bg="$bg"

