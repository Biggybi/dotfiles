if exists('g:plugin_cursor')
  finish
endif
let g:plugin_cursor = 1

if &term =~ "xterm\\|rxvt"
  let &t_SI = "\e[5 q"       " insert mode: vertical line
  let &t_EI = "\e[2 q"       " normal mode: block
  let &t_SR = "\e[4 q"       " replace mode: underscore
endif
