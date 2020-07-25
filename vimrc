" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    vimrc                                              :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: tris <tris@tristankapous.com>              +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2016/04/14 18:58:30 by tris              #+#    #+#              "
"    Updated: 2020/05/29 04:18:38 by tris             ###   ########lyon.fr    "
"                                                                              "
" **************************************************************************** "

""    Settings
"""        Pathogen

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

"""        General settings

runtime! ftplugin/man.vim
if ! has("nvim")
  packadd! matchit
  packadd! termdebug
endif

filetype plugin on                   " use filetype plugin
filetype on
filetype indent on                   " use indent plugin
set keywordprg=:Man

let $BASH_ENV = "$HOME/dotfiles/bash_aliases"  " use aliases in vim
let $PAGER=''                        " vim as pager

syntax on
if &compatible                       " condition avoid pile-up
  set nocompatible                   " not compatible with vi
endif
set encoding=utf-8                   " character encoding
scriptencoding utf8
set ttyfast                          " faster redrawing
set nolazyredraw                     " no redraw executing macros

"""        Restore

" Session restore
set sessionoptions-=options
set viewoptions=folds    "only these settins
" restore undo history
if exists('+undofile')
  set undofile
endif

set history=10000               " long history
set hidden

if exists('$SUDO_USER')         " don't create root-owned files
  set noswapfile
  set nobackup
  set nowritebackup
  set noundofile
  set viminfo=
else
  set backupdir=$HOME/.vim/tmp/backup//
  set directory=$HOME/.vim/tmp/swap//
  set undodir=$HOME/.vim/tmp/undo//
  set viewdir=$HOME/.vim/tmp/view//
  if has("nvim")
    set viminfo+=n$HOME/.vim/tmp/viminfo/nviminfo
  else
    set viminfo+=n$HOME/.vim/tmp/viminfo/viminfo
  endif
endif

if !isdirectory(&backupdir) | call mkdir(&backupdir, "p") | endif
if !isdirectory(&directory) | call mkdir(&directory, "p") | endif
if !isdirectory(&undodir) | call mkdir(&undodir, "p") | endif
if !isdirectory(&viewdir) | call mkdir(&viewdir, "p") | endif

set autoread                    " auto load file changes
" set autowrite                   " auto save file changes
set modelineexpr                " flexible modeline set

"""        User Interface settings

" Title
set title                       " window title (file)

" Mappings chill
set notimeout                   " no timeout on maps
set ttimeout                    " timeout on keycodes
set ttimeoutlen=10              " of 10 ms
set mouse=a                     " it's a secret

" search
set magic                       " set magic on, for regex
set ignorecase                  " case insensitive search
set smartcase                   " case-sens if cap
set hlsearch                    " highlight all searches
set incsearch                   " highlight match while typing
" set path+=**                  " recursive path from current path
" ignore some files from wildcard expansion
set nrformats-=octal            " <c-a>/<c-x> do not use octals

set wildignore+=**/__pycache__/**
set wildignore+=**/venv/**
set wildignore+=**/node_modules/**
set wildignore+=**/dist/**
set wildignore+=**/build/**
set wildignore+=*.o
set wildignore+=*.pyc
set wildignore+=*.swp

" Command line window
set cmdheight=2                 " Command-line height
set showcmd                     " show command
set wildmenu                    " show matches to commands
set wildchar=<tab>              " complete w/ tab
set wildmode=longest,full
set fileignorecase              " ignore case using filename
set wildignorecase              " ignore case completing filenames

" status line
set laststatus=2                " always show satus line
set ruler                       " show cursor line / column
set noshowmode
" set statusline=%02n:%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P  " show buffer number

" Shortmess : 'hit enter' prompt custzomization
set shortmess+=A                " Always edit if swap exists
set shortmess+=f                " Abbrev file count
set shortmess+=i                " Abbrev line without end
set shortmess+=l                " Abbrev line and word count
set shortmess+=m                " Abbrev modified
set shortmess+=n                " Abbrev new file
set shortmess+=r                " Abbrev read only
set shortmess+=w                " Abbrev writter
set shortmess+=x                " Abbrev dos and mac format
set shortmess+=W                " No message when writing
set shortmess+=F                " As if silent autocomands
set shortmess+=c                " No ins completion message
set shortmess+=s                " No "search hit BOTTOM" message

" insert complete menu
set completeopt+=longest        " complete matching string
set completeopt+=menuone        " pmenu on single match too

" Bell
set visualbell                  " do not ring the bell
set noerrorbells                " no bell for error messages
set t_vb=                       " no bell at all

" tabulation control
set noexpandtab                 " tabs ftw
set smarttab                    " tab width start of line
set tabstop=4                   " visible width of tabs
set softtabstop=4               " tabs 4 characters wide
set shiftwidth=4                " indents 4 characters wide
set autoindent                  " automatically indent new line
set smartindent                 " ...in a sane way
set shiftround                  " indent congru shiftwidth

" splits
set switchbuf=usetab            " open buffer window if exists
set splitbelow                  " default split below
set splitright                  " default split right
" set list

" guides smartisation
set fillchars+=vert:▎
set listchars=tab:\▎\ ,trail:-  " only tab / trailing ws
set spellcapcheck=              " ignore leading cap in word
set nojoinspaces                " and spaces too
set suffixesadd=.tex,.latex,.java,.c,.h,.js    " match file w/ ext
augroup NoAutoComment
  au!
  au FileType *
        \ setlocal formatoptions+=j    " join comments smartly
        \ setlocal formatoptions-=cro  " no auto comment line
augroup end

" Main window
set display+=lastline           " show lastline even if too long
set number                      " show number column
set wrap                        " no horizontal scroll
set breakindent                 " with indent
set showbreak=¬                 " ... showing a character

" Moves boundaries
set backspace=indent,eol,start  " backspace over lines
set whichwrap+=<,>,h,l,[,]      " break cursor free
set virtualedit=block           " visual selection broken free
set nostartofline               " vertical moves in same column
set sidescrolloff=5             " min horizontal cursor offset
let &scrolloff=winheight(win_getid())/10 + 1  " min vertical cursor offset
" set iskeyword+=,              " considered part of <cword>

" Folding
set foldmethod=syntax           " fold based on indent
set foldnestmax=2               " deepest fold is 10 levels
set nofoldenable                " don't fold by default

" Colors
let base16colorspace=256        " access 256 colorspace
set t_Co=256                    " say terminal supports 256
if has("termguicolors")
  set termguicolors             " 24 bits colors
endif

" False cursorline to have CursorLineNr working
set cursorline

" Tabline
set tabpagemax=30

""    Look / Theme
"""        DarkLightSwitch

let g:theme_list = ['base16-one-light', 'base16-one-lightdim', 'base16-onedark', 'base16-one-lightdim']
" let g:theme_force_load_start = 'base16-one-lightdim'
let g:daytime = [7, 19]
let g:theme_force_load_start = get(g:, 'theme_force_load_start')
let g:theme_source_sensitive = 0

function! SelectColorScheme() abort
  if g:theme_force_load_start != '0'
    if index(g:theme_list, g:theme_force_load_start) >= 0
      exe "colorscheme" g:theme_force_load_start
    else
      echom "Auto theme not found:" g:theme_force_load_start . ". Using default:" g:theme_list[0]. "."
      exe "colorscheme" g:theme_list[0]
    endif
    unlet g:theme_force_load_start
  else
    let hour = strftime("%H")
    if g:daytime[0] <= hour && hour <= g:daytime[1]
      exe "colorscheme" g:theme_list[1]
    else
      exe "colorscheme" g:theme_list[2]
    endif
  endif
endfunction
if ! exists("g:theme_change")
  call SelectColorScheme()
endif
if g:theme_source_sensitive == 1
  call SelectColorScheme()
endif

function! DarkLightSwitch() abort
  if ! exists('g:theme_change')
    let g:theme_current_index = index(g:theme_list, g:colors_name)
  endif
  if ! exists('g:theme_current_index')
    let g:theme_current_index = index(g:theme_list, g:colors_name)
  endif
  let g:theme_current_index += 1
  if g:theme_current_index == len(g:theme_list)
    let g:theme_current_index = 0
  endif
  exe "colorscheme" g:theme_list[g:theme_current_index]
  let g:theme_change = 1
endfunction

"""        Title

augroup WinTitle
  au!
  au BufRead,BufEnter * let &titlestring = MyWindowTitle()
augroup end

function! GetGitRepoName(file) abort
  let l:path=fnamemodify(a:file, ':p')
  while l:path != '' && l:path != '/'
    let l:path=fnamemodify(l:path, ':h')
    let l:candidate=l:path . '/.git'
    let l:folder=substitute(l:path, '/.*/', '', '')
    if isdirectory(l:path . '/.git')
      return l:folder
    endif
  endwhile
  return ''
endfunction

function! MyWindowTitle() abort
  let l:hostname = hostname() . "   ▏ "
  let l:file = substitute(expand('%'), '/.*/', '', '')
  let gitrepo = GetGitRepoName('%') . "   〉  "
  return(hostname . gitrepo . file)
endfunction

"""        Cursor

if &term =~ "xterm\\|rxvt"
  let &t_SI = "\e[5 q"       " insert mode
  let &t_EI = "\e[2 q"       " normal mode
  let &t_SR = "\e[4 q"       " replace mode
endif

"""        Term Background
" " Conflict with SetColorScheme:
" " g:colors_name not found if change theme + restart vim
" " Auto set terminal background color to Vim's
" autocmd ColorScheme * call s:matchTerminalBackground()
" fun! s:matchTerminalBackground()
"   let l:background = synIDattr(synIDtrans(hlID("Normal")), "bg#")
"   exec 'silent !echo -e "\e]11;\' . l:background . '\a"'
" endfun

"""        StatusLine

let g:currentmode={
      \ '__'     : '- ',
      \ 'c'      : 'C ',
      \ 'i'      : 'I ',
      \ 'ic'     : 'I ',
      \ 'ix'     : 'I ',
      \ 'n'      : 'N ',
      \ 'multi'  : 'M ',
      \ 'ni'     : 'N ',
      \ 'no'     : 'N ',
      \ 'R'      : 'R ',
      \ 'Rv'     : 'R ',
      \ 's'      : 'S ',
      \ 'S'      : 'S ',
      \ ''     : 'S ',
      \ 't'      : 'T ',
      \ 'v'      : 'V ',
      \ 'V'      : 'V ',
      \ ''     : 'V ',
      \}

function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return [a,m,r] == [0,0,0] ? '' : '[+]'
  " return join(['[+'.a,'~'.m,'-'.r.']'])
endfunction

function! GetColor(group_fg, group_bg) abort
  let group_fg = synIDattr(hlID(a:group_fg), "fg#")
  let group_bg = synIDattr(hlID(a:group_bg), "bg#")
  return "guifg=".group_fg . " guibg=".group_bg
endfunction

function! SetStatusLineColorsInsert() abort
  exe "hi User1 " . GetColor('StatusLineInsert', 'StatusLineInsert')
endfunction

function! SetStatusLineColorsVisual() abort
  exe "hi User1 " . GetColor('StatusLineVisual', 'StatusLineVisual')
endfunction

function! SetStatusLineColorsCommand() abort
  exe "hi User1 " . GetColor('StatusLineCmd', 'StatusLineCmd')
endfunction

function! SetStatusLineColorsPending() abort
  exe "hi" g:mode_marker_group "guifg= " g:cmd_change_fg "guibg= " g:cmd_change_bg
  exe "hi User1 " . GetColor('StatusLinePending', 'StatusLinePending')
endfunction

function! SetStatusLineColorsNormal() abort
  exe "hi User1 " . GetColor('StatusLineNormal', 'StatusLineNormal')
  exe "hi User2 " . GetColor('StatusLineActiveLeft', 'StatusLineActiveLeft')
  exe "hi User3 " . GetColor('StatusLineVisual', 'StatusLineVisual')
  exe "hi User4 " . GetColor('StatusLineInsert', 'normal')
  exe "hi User5 " . GetColor('normal', 'normal')
  exe "hi" g:mode_marker_group "guifg= " g:save_fg "guibg=" g:save_bg
endfunction

function StatusLineActive() abort
  setlocal statusline =
  setlocal statusline +=%1*\ %-2{g:currentmode[mode()]}%*  "mode
  setlocal statusline +=%2*\ %{FugitiveHead()}             "git branch
  setlocal statusline +=%r%h%w                             "read only, special buffers
  setlocal statusline +=%{GitStatus()}\ %*                 "git modified
  setlocal statusline +=\ %f                               "filename
  setlocal statusline +=%{&modified?'[+]':''}\ %*          "file modified
  setlocal statusline +=%{anzu#search_status()}            "search results
  setlocal statusline +=%=%2*%=\ %{&filetype}\ %*          "filetype
  setlocal statusline +=%1*\ \[%=%5l:                      "current line
  setlocal statusline +=%4v\]                              "virtual column number
  setlocal statusline +=/[%L:                              "total lines
  setlocal statusline +=%2p%%\]%*                          "Rownumber/total (%)
  setlocal statusline+=%<                                  " cut at end
endfunction

function StatusLineInactive() abort
  setlocal statusline =
  setlocal statusline +=%f                                "filename
  setlocal statusline +=%{&modified?'[+]':''}             "file modified
  setlocal statusline +=%{GitStatus()}                    "git modified
  setlocal statusline +=%=%{&filetype}\                   "filetype
endfunction

augroup StatusLineSwitch
  au!
  au InsertEnter * call SetStatusLineColorsInsert()
  " au InsertLeave * call SetStatusLineColorsNormal()
  " au Visual * call SetStatusLineColorsInsert()
  au WinEnter,BufWinEnter * call StatusLineActive()
  au WinLeave * call StatusLineInactive()
  " todo: does not trigger on sourcing
  au ColorScheme,VimEnter *
        \ let g:save_fg = synIDattr(hlID(g:mode_marker_group), "fg#") |
        \ let g:save_bg = synIDattr(hlID(g:mode_marker_group), "bg#")
  au VimEnter,ColorScheme,InsertLeave,CmdwinLeave *
        \ call SetStatusLineColorsNormal() |
        \ call StatusLineActive()
augroup end

"""        Pending command mode

let g:mode_marker_group = "CursorLineNr"
let g:cmd_change_fg = "#383a42"
let g:cmd_change_bg = "#e06c75"
let g:ins_change_fg = "#383a42"
let g:ins_change_bg = "#98c379"

if ! has("nvim")
  call timer_start(10, 'CheckModeAndState', {'repeat': -1})
  function! CheckModeAndState(_) abort
    if mode() ==? 'i'
      return
    endif
    if mode() ==? 'v' || mode() ==? ''
      call SetStatusLineColorsVisual()
      return
    endif
    if mode() ==? 'r'
      call SetStatusLineColorsInsert()
      return
    endif
    if mode() ==? 'c'
      call SetStatusLineColorsCommand()
      return
    endif
    if state() =~# '[moS]'
      call SetStatusLineColorsPending()
      return
    else
      call SetStatusLineColorsNormal()
      return
    endif
  endfunction
endif

augroup PendingInsertModeHl
  au!
  " au SafeState * exe "hi" g:mode_marker_group "guifg=" . g:save_fg "guibg=" . g:save_bg
  au InsertEnter * exe "hi" g:mode_marker_group "guifg=" . g:ins_change_fg "guibg=" . g:ins_change_bg
  au InsertLeave * exe "hi" g:mode_marker_group "guifg=" . g:save_fg "guibg=" . g:save_bg
augroup end

" augroup SavePendingGroupColor
"   au!
"   au ColorScheme,VimEnter *
"         \ let g:save_fg = synIDattr(hlID(g:mode_marker_group), "fg#") |
"         \ let g:save_bg = synIDattr(hlID(g:mode_marker_group), "bg#")
" augroup end

""    Extra windows
"""        Terminal

" Show terminal (like c-z), exit on any character
function! ShowTerm() abort
  silent !read -sN 1
  redraw!
endfunction
nnoremap [= :call ShowTerm()<cr>

function! PutTermPanel(buf, side, size) abort
  " new term if no buffer
  if a:buf == 0
    term
  else
    execute "sp" bufname(a:buf)
  endif
  " default side if wrong argument
  if stridx("hjklHJKL", a:side) == -1
    execute "wincmd" "J"
  else
    execute "wincmd" a:side
  endif
  " horizontal split resize
  if stridx("jkJK", a:side) >= 0
    if ! a:size > 0
      resize 6
    else
      execute "resize" a:size
    endif
    return
  endif
  " vertical split resize
  if stridx("hlHL", a:side) >= 0
    if ! a:size > 0
      vertical resize 6
    else
      execute "vertical resize" a:size
    endif
  endif
endfunction

function! s:ToggleTerminal(side, size) abort
  let tpbl=[]
  let closed = 0
  let tpbl = tabpagebuflist()
  " hide visible terminals
  for buf in filter(range(1, bufnr('$')), 'bufexists(bufname(v:val)) && index(tpbl, v:val)>=0')
    if getbufvar(buf, '&buftype') ==? 'terminal'
      silent execute bufwinnr(buf) . "hide"
      let closed += 1
    endif
  endfor
  if closed > 0
    return
  endif
  " open first hidden terminal
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)<0')
    if getbufvar(buf, '&buftype') ==? 'terminal'
      call PutTermPanel(buf, a:side, a:size)
      return
    endif
  endfor
  " open new terminal
  call PutTermPanel(0, a:side, a:size)
endfunction

function! s:PopupTerminal() abort
  let buf = term_start("bash", #{hidden: 1, term_finish: 'close'})
  let winid = popup_dialog(buf, #{minwidth: 80, minheight: 20, border:[]})
  return
endfunction

"""        Quickfix

augroup QuickFixWindowSet
  au!
  au FileType qf setlocal colorcolumn=0 nolist nocursorline tw=0 norelativenumber showbreak=

  " vimscript is a joke
  au FileType qf nnoremap <buffer> <cr> :execute "normal! \<lt>cr>"<cr>
  " auto adjust height if not a vertical split (hopefuly)
  au Filetype qf nnoremap <buffer> j <c-n>
  au Filetype qf nnoremap <buffer> k <c-p>
  au FileType qf
        \ if winheight('quickfix') + 3 < &lines
        \ |   call AdjustWindowHeight(1, 5)
        \ | endif
  au QuickfixCmdPost make call QfMakeConv()
augroup end

" Change encoding of error file for quickfix
function! QfMakeConv() abort
  let qflist = getqflist()
  for i in qflist
    let i.text = iconv(i.text, "cp936", "utf-8")
  endfor
  call setqflist(qflist)
endfunction

" Quickfix window height auto adjust if too big
function! AdjustWindowHeight(minheight, maxheight)
  let l = 1
  let n_lines = 0
  let w_width = winwidth(0)
  while l <= line('$')
    " number to float for division
    let l_len = strlen(getline(l)) + 0.0
    let line_width = l_len/w_width
    let n_lines += float2nr(ceil(line_width))
    let l += 1
  endw
  exe max([min([n_lines, a:maxheight]), a:minheight]) . "wincmd _"
endfunction

" Auto location list on make
" augroup AutoLocationWindow
"   au!
"   autocmd QuickFixCmdPost [^l]* nested lwindow
"   autocmd QuickFixCmdPost    l* nested lwindow
" augroup end

" nnoremap <leader>cc :ll<cr>
" nnoremap <leader>cn :lnext<cr>
" nnoremap <leader>cp :lprevious<cr>

" nnoremap ]<c-q> :cc<cr>
" nnoremap [q :cprev<cr>
" nnoremap ]q :cnext<cr>
" nnoremap [Q :cfirst<cr>
" nnoremap ]Q :clast<cr>

" nnoremap [<c-w> :ll<cr>
" nnoremap [w :lprev<cr>
" nnoremap ]w :lnext<cr>
" nnoremap [W :lfirst<cr>
" nnoremap ]W :llast<cr>

"""        Help/Man

let g:ft_man_open_mode = 'vert'

augroup HelpManSplit
  au!
  au FileType man wincmd H
  au FileType man setlocal tabstop=8
  au FileType help,man setlocal showbreak= nonumber signcolumn=no
  au FileType help au! BufRead,BufEnter <buffer> silent!
        \ | :silent! wincmd H | :silent! 82 wincmd|
  au FileType help au! BufLeave,WinLeave <buffer> silent!
        \ | if &columns < 100 | :silent! 0 wincmd| | endif
augroup end

"""        Shell output split

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>, 'J')
command! -complete=shellcmd -nargs=+ VShell call s:RunShellCommand(<q-args>, 'L')
function! s:RunShellCommand(cmdline, direction) abort
  if bufexists('scratch_terminal_output')
    bw! scratch_terminal_output
  endif
  let current_window = win_getid()
  wincmd v
  wincmd J
  if has("nvim")
    exe 'terminal '. a:cmdline
  else
    exe 'terminal ++curwin '. a:cmdline
  endif
  file scratch_terminal_output
  let term_window = win_getid()
  let term_buf_nr = buffer_number()
  if a:direction == 'L'
    wincmd L
  elseif a:direction == 'H'
    wincmd H
  elseif a:direction == 'J'
    wincmd J
    6 wincmd _
  elseif a:direction == 'K'
    wincmd K
    6 wincmd _
  endif
  if win_getid() != current_window
    call win_gotoid(current_window)
  endif
endfunction

function! MoveScrathTerm(direction) abort
  if bufexists('scratch_terminal_output')
    let current_window = win_getid()
    sbuffer scratch_terminal_output
    if a:direction == 'L'
      wincmd L
    elseif a:direction == 'H'
      wincmd H
    elseif a:direction == 'J'
      wincmd J
      10 wincmd _
    elseif a:direction == 'K'
      wincmd K
      10 wincmd _
    elseif a:direction == 'Q'
      :bw
    endif
    call win_gotoid(current_window)
  endif
endfunction

"""        Job split output

command! -complete=shellcmd -nargs=+ Shell2 call s:TmpShellOutput(<q-args>)
function! s:TmpShellOutput(cmdline) abort
  if bufexists('tmplog')
    call deletebufline('tmplog', 1, '$')
  else
    call bufadd('tmplog')
    call setbufvar('tmplog', "buftype", "nofile")
    call setbufvar('tmplog', "filetype", "")
  endif
  " let logjob = job_start(execute("!bash " . a:cmdline),
  if has("nvim")
    let logjob = jobstart(["/bin/bash", "-c", a:cmdline],
          \ {'out_io': 'buffer', 'out_name': 'tmplog', 'out_msg': ''})
  else
    let logjob = job_start(["/bin/bash", "-c", a:cmdline],
          \ {'out_io': 'buffer', 'err_io': 'buffer', 'out_name': 'tmplog', 'err_name': 'tmplog', 'out_msg': ''})
  endif
  let winnr = win_getid()
  vert sbuffer tmplog
  setlocal wrap
  " nnoremap <buffer> <c-c> :call job_stop('logjob')<cr>
  wincmd L
  60 wincmd |
  if win_getid() != winnr
    call win_gotoid(winnr)
  endif
endfunction

"""        Scrolling

" Do not scroll past the end of file (last line locked at bottom of window)
function! NoScrollAtEOF() abort
  let curpos = getpos('.')
  let lnum = get(curpos, 1, -1)
  let len = line('$')
  if lnum + winheight(0) >= len
    normal! zb
  endif
endfunction
" nnoremap <c-f> <c-f> <silent> :call NoScrollAtEOF()<cr>
nmap <c-f> <Plug>(SmoothieForwards)<bar><silent> :call NoScrollAtEOF()<cr>

"""        Mail

augroup MailSettings
  au!
  autocmd FileType mail setlocal linebreak tw=0
augroup end

"""        Markdown

augroup MarkdownSettings
  au!
  au FileType markdown setlocal linebreak
augroup end

"""        Search cycling windows

function! CycleWindowsSearch(direction) abort
  let forward = a:direction
  if ! v:searchforward
    let forward = forward ? '0' : '1'
  endif
  let searchflags = forward ? 'W' : 'Wb'
  let winmove = forward ? 'w' : 'W'
  let curmove = forward ? '1' : '$'

  let firstwin=winnr()
  if ! search(@/, searchflags)
    execute('wincmd ' . winmove)
    let savepos = getcurpos()
    call cursor(curmove, curmove)
    while ! search(@/, searchflags) && firstwin != winnr()
      call setpos('.', savepos)
      execute('wincmd ' . winmove)
      call cursor(curmove, curmove)
    endwhile
  endif
endfunction

" nnoremap <silent> n :call CycleWindowsSearch('1')<cr>
" nnoremap <silent> N :call CycleWindowsSearch('0')<cr>

"""        History

" Auto remove some commands from history
let g:commands_to_delete_from_history = ['Delete', 'bw', 'bd']

function! DeleteCommandsFromHistory()
  let lastHistoryEntry = histget('cmd', -1)
  if trim(lastHistoryEntry) == ""
    return
  endif
  let lastCommand = split(lastHistoryEntry, '\s\+')[0]
  if (index(g:commands_to_delete_from_history, lastCommand) >= 0)
    call histdel('cmd', -1)
  endif
endfunction

augroup history_deletion
  autocmd!
  autocmd CmdlineLeave * call DeleteCommandsFromHistory()
augroup END

""    Highlights / Match
"""        show traling whitespaces

augroup TrailSpace
  au!
  au BufWinEnter * match TrailSpace /\s\+$/
  au InsertEnter * match TrailSpace /\s\+\%#\@<!$/
  au InsertLeave * match TrailSpace /\s\+$/
  au BufWinLeave * call clearmatches()
augroup end

"""        color column 81 for code

augroup ColorColumn
  au!
  if exists('+colorcolumn')
    au FileType c,cpp,css,java,python,ruby,bash,sh,js,html,javascript setlocal colorcolumn=81
  endif
augroup end

"""        search cycle colors

" highlight current search and first/last search differently
function! HLCurrent() abort
  if exists("currmatch")
    call matchdelete(currmatch)
  endif
  " only on cursor
  let patt = '\c\%#'.@/
  " check prev and next match
  let prevmatch = search(@/, 'bWn')
  let nextmatch = search(@/, 'Wn')
  " if on first or last match
  if prevmatch == 0 || nextmatch == 0
    let currmatch = matchadd('EdgeSearch', patt, 101)
  else
    let currmatch = matchadd('IncSearch', patt, 101)
  endif
  redraw
endfunction

""    File automation
"""        Save and load

" Save when focus lost, load when focus gained
augroup AutoSaveAndLoadWithFocus
  au!
  au FocusGained,BufEnter * :silent! !
  au FocusLost,WinLeave * :silent! w
augroup end

"""        Last cursor position

" Open file where it was last closed
augroup ReOpenFileWhereLeft
  au!
  au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") && &ft !~# 'gitcommit'
        \ |   exe "normal! g`\""
        \ | endif
augroup end

"""        Files views

" save folding state (and more based on 'viewoptions')
if ! has("nvim")
  augroup ReViews
    au!
    au BufWinLeave *
          \ if expand("%") != "" && &filetype != 'help' && &filetype != 'man'
          \ |   mkview
          \ | endif
    au BufWinEnter *
          \ if expand("%") != "" && &filetype != 'help' && &filetype != 'man'
          \ |   silent! loadview
          \ | endif
  augroup end
endif

"""        Working directory

" change dir to git repo OR file directory
augroup CdGitRootOrFileDir
  au!
  au BufEnter,BufRead *
        \ if !empty(bufname("%"))
        \ |   silent! cd %:p:h | silent! Glcd
        \ | endif
augroup end

"""        Tags and paths

" Get tags file from git repo
" Set path for code projects
augroup CodePathTags
  au!
  au BufEnter * silent! set tags+=.git/tags
  au FileType make,c,cpp,css,java,python,ruby,js,json,javascript,sh au! BufRead,BufEnter <buffer> silent!
        \ | set path+=inc,incs,includes,include,headers,src,srcs,sources,js,html,ruby,python,javascript,tscript,typescript
augroup end

" autoreload tags file on save
" au BufWritePost *.c,*.cpp,*.h silent! !ctags -R --langmap=c:.c.h &
" au BufWritePost *.cpp silent! !ctags -R &
set tags=tags;./git/

"""        Completion by filetype

augroup AutoOmniComplete
  au!
  au FileType c setlocal ofu=ccomplete#CompleteCpp
  au FileType css setlocal ofu=csscomplete#CompleteCSS
  au FileType html,xhtml setlocal ofu=htmlcomplete#CompleteTags
  au FileType php setlocal ofu=phpcomplete#CompletePHP
  au FileType ruby,eruby setlocal ofu=rubycomplete#Complete
augroup end

"""        Filetype recognition

augroup AutoFileTypeRecognition
  au!
  au BufNewFile,BufFilePre,BufRead *.md,markdown set filetype=markdown
  au BufNewFile,BufFilePre,BufRead *.sh,bash,zsh set filetype=sh
  au BufNewFile,BufFilePre,BufRead *.c,h,cpp set filetype=c
  au BufNewFile,BufFilePre,BufRead *.php set filetype=php
  au BufNewFile,BufFilePre,BufRead *.css set filetype=css
  au BufNewFile,BufFilePre,BufRead *.html,htm set filetype=html
  au BufNewFile,BufFilePre,BufRead *.js set filetype=javascript
  au BufNewFile,BufFilePre,BufRead *.json set filetype=json
  au BufNewFile,BufFilePre,BufRead *.groovy,gradle set filetype=groovy
  au BufNewFile,BufFilePre,BufRead *.java set filetype=java
  " au BufNewFile,BufNew,BufFilePre,BufRead,BufEnter *.php set filetype=html syntax=phtml
augroup end

"""        Filetype refresh

"  refresh filetype upon writing if no filetype already set
augroup FileTypeRefresh
  au!
  au BufWrite * if &ft ==# '' | filetype detect | endif
augroup end

"""        File suffixes

" set suffixes to try when matching a file name
function! SetSuffixes() abort
  let associations = [
        \["javascript", ".js,.javascript,.es,.esx,.json"],
        \["python", ".py,.pyw"],
        \["c", ".c,.h"],
        \["cpp", ".c,.h"]
        \]
  for ft in associations
    execute "au FileType " . ft[0] . " setlocal suffixesadd=" . ft[1]
  endfor
endfunction

augroup SuffixesTry
  au!
  au FileType javascript,c,cpp,python call SetSuffixes()
augroup end

"""        Large Files

" large file = 10MB
let g:LargeFile = 1024 * 1024 * 10
augroup LargeFilesFast
  au!
  au BufReadPre *
        \ let f=expand("<afile>")
        \ | if getfsize(f) > g:LargeFile
        \ |   let b:airline_whitespace_checks = ['']
        \ |   au! anzu
        \ | endif
augroup end

"""        Auto Load Project Files

function! AutoProjectLoad(is_mapping) abort
  let filelist = ".git/vim/project_files"
  if ! filereadable(filelist)
    return
  endif
  if bufname("%") != "" && a:is_mapping == 0
    return
  endif
  exe "e" filelist
  " silent! tabonly
  " " open first WORD of each line
  " g/\v^.*[^\s]/ if filereadable(expand('<cWORD>')) | argadd <cWORD> | $tabnew <cWORD> | tabfirst | endif
  g/\v^[^#].*[^\s]/ if filereadable(expand(expand('<cWORD>'))) | argadd <cWORD> | endif
  exe "bw" filelist
  wincmd p
endfunction

augroup AutoProjectLoadOnStart
  au!
  autocmd VimEnter * ++nested call AutoProjectLoad('0')
augroup end

nnoremap <leader>ej :e .git/vim/project_files<cr>

""    Plugins settings
"""        Netrw

augroup AutoDeleteNetrwHiddenBuffers
  au!
  au FileType netrw setlocal bufhidden=wipe
augroup end

" Netrw customization
let g:netrw_keepdir= 0
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 2
let g:netrw_altv = 1
let g:netrw_winsize = 20
let g:netrw_sort_sequence = '[\/]$,*'  " sort folders on top

" open netrw if vim starts without file
let g:netrw_startup = 0
let g:netrw_startup_no_file = 0
augroup NetrwStartup
  au!
  au VimEnter * if g:netrw_startup_no_file == '1' && expand("%") == "" | e . | endif
  au VimEnter * if g:netrw_startup == '1' && expand('%') == "" | Lexplore | wincmd w | endif
augroup end

"""        Termdebug

" let g:termdebug_wide = 163
let g:termdebug_wide = 40

"""        Fugitive

nnoremap <silent> <leader>gg :vertical Gstatus<cr>
set diffopt+=vertical " vertical split for diff
augroup FugitiveSet
  au!
  " au FileType gitcommit start
  au FileType fugitive setlocal cursorline norelativenumber nonumber colorcolumn=0
augroup end

function! FugitiveBlameToggle() abort
  let current_window = win_getid()
  wincmd h
  if &ft ==? "fugitiveblame"
    wincmd q
  else
    call win_gotoid(current_window)
    :Gblame
  endif
  call win_gotoid(current_window)
endfunction

nnoremap <leader>gb :call FugitiveBlameToggle()<cr>

"""        Airline

let g:airline_mode_map = {
      \ '__'     : '-',
      \ 'c'      : 'C',
      \ 'i'      : 'I',
      \ 'ic'     : 'I',
      \ 'ix'     : 'I',
      \ 'n'      : 'N',
      \ 'multi'  : 'M',
      \ 'ni'     : 'N',
      \ 'no'     : 'N',
      \ 'R'      : 'R',
      \ 'Rv'     : 'R',
      \ 's'      : 'S',
      \ 'S'      : 'S',
      \ ''     : 'S',
      \ 't'      : 'T',
      \ 'v'      : 'V',
      \ 'V'      : 'V',
      \ ''     : 'V',
      \ }

let g:airline#extensions#default#section_truncate_width = {}
let g:airline#extensions#default#layout = [
      \ [ 'a', 'b', 'c' ],
      \ [ 'x', 'y', 'z', 'error', 'warning' ]
      \ ]

call airline#parts#define_minwidth('branch', 20)

let g:airline_symbols_ascii = 1
let g:airline_section_b = '%{airline#util#wrap(airline#extensions#branch#get_head(),20)}%{GitStatus()}'
let g:airline_section_z = '%4{line(".")}:%-3{virtcol(".")} %-4{LinePercent()}'
let g:airline_section_y = '%{&filetype}'
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#coc#enabled = 0

function! LinePercent() abort
  return line('.') * 100 / line('$') . '%'
endfunction

function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return [a,m,r] == [0,0,0] ? '' : '[+]'
  " return join(['[+'.a,'~'.m,'-'.r.']'])
endfunction

"""        Gitgutter / GitMessenger
if exists('&signcolumn')        " Vim 7.4.2201
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif
set updatetime=100              " need for Coc + gitgutter

let g:gitgutter_max_signs = 1000

let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_removed = '│'
let g:gitgutter_sign_removed_first_line = '▔'
let g:gitgutter_sign_modified_removed = '│'

nmap ghm <Plug>(git-messenger-close)<bar><Plug>(git-messenger)
if ! has("nvim")
  let g:git_messenger_close_on_cursor_moved = 'false'
  let g:git_messenger_into_popup_after_show = 'false'
endif

nmap ghp <Plug>(GitGutterPreviewHunk)
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)

omap ih <Plug>(GitGutterTextObjectInnerPending)
omap ah <Plug>(GitGutterTextObjectOuterPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)
xmap ah <Plug>(GitGutterTextObjectOuterVisual)

"""        FZF

let g:fzf_command_prefix = 'Fzf'
let g:fzf_buffers_jump = 1      " [Buffers] to existing split

function! s:build_location_list(lines) abort
  call setloclist(0, map(copy(a:lines), '{ "filename": v:val }'))
  lopen
endfunction

function! s:build_quickfix_list(lines) abort
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
endfunction

" An action can be a reference to a function that processes selected lines
let g:fzf_action = {
      \ 'ctrl-q': function('s:build_quickfix_list'),
      \ 'ctrl-l': function('s:build_location_list'),
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit'}

nnoremap <silent> <leader>ff :FzfFiles $HOME<cr>
nnoremap <silent> <leader><c-f> :call getcwd() <bar> :FzfFiles<cr>
nnoremap <silent> <leader>F :FzfFiles .<cr>
nnoremap <silent> <leader>fb :FzfBuffers<cr>
nnoremap <silent> <leader>b :FzfBuffers<cr>
nnoremap <silent> <leader>j :FzfBuffers<cr>
nnoremap <silent> <leader>fw :FzfWindows<cr>
nnoremap <silent> <leader>ft :FzfTags<cr>
nnoremap <silent> <leader>f<c-t> :FzfBTags<cr>
nnoremap <silent> <leader>fc :FzfCommit<cr>
nnoremap <silent> <leader>f<c-c> :FzfBCommit<cr>
nnoremap <silent> <leader>fg :FzfGFiles?<cr>
nnoremap <silent> <leader>f<c-g> :FzfGFiles<cr>
nnoremap <silent> <leader>fl :FzfLines<cr>
nnoremap <silent> <leader>f<c-l> :FzfBLines<cr>
nnoremap <silent> <leader>f; :FzfHistory:<cr>
nnoremap <silent> <leader>f/ :FzfHistory/<cr>
nnoremap <silent> <leader>fh :FzfHistory<cr>
nnoremap <silent> <leader>fm :FzfHelptags<cr>
nnoremap <silent> <leader>fs <esc>:FzfSnippets<cr>
nnoremap <silent> <leader>fr <esc>:Rg<cr>
inoremap <silent> <c-x><c-s> <c-o>:FzfSnippets<cr>

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

let g:fzf_tags_command = 'ctags -R'
" big floating window
" let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'rounded' } }

" bottom floating window
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.3,'yoffset':0.9,'xoffset': 0.4, 'highlight': 'normal', 'border': 'sharp' } }
" let g:fzf_layout = {'heigh': '40%'}

let $FZF_DEFAULT_OPTS = '--info=inline -m --preview "head -n 500 {}" --bind "ctrl-o:toggle+up,ctrl-i:toggle+down,ctrl-space:toggle-preview,ctrl-a:toggle-all,ctrl-u:preview-up,ctrl-d:preview-down"'
let $FZF_DEFAULT_COMMAND="rg --files --hidden --glob '!.git/**'"
"-g '!{node_modules,.git}'

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'gutter':  ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'Visual', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'vertsplit'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
  " \ 'border':  ['fg', 'Conditional'],

"Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

" Get text in files with Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   "rg --column --line-number --no-heading --color=always --smart-case --glob '!.git/**' ".shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen) abort
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Git grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

"""        Latex Live Preview

" au FileType tex,plaintex let g:tex_fold_enabled=1
augroup TexSet
  au!
  au FileType tex setlocal updatetime=1000
  " let g:livepreview_previewer = 'zathura'
  " let g:livepreview_cursorhold_recompile = 0
  " let g:livepreview_engine = 'your_engine' . ' [options]'
augroup end

"""        Vim-run
let g:vim_run_command_map = {
      \'javascript': 'node',
      \'php': 'php',
      \'python': 'python',
      \'markdown': 'markdown',
      \}

"""        Vimwiki

augroup VimWikiSettings
  au!
  au FileType vimwiki setlocal nonu nornu showbreak= nobreakindent linebreak
  au FileType vimwiki nnoremap <buffer> <leader>cr <Plug>(VimwikiToggleListItem)
augroup end

let g:vimwiki_list = [{'path': '~/vimwiki/',
      \ 'syntax': 'markdown', 'ext': '.md'}]

" no vimwiki filetype outside wiki folder
let g:vimwiki_global_ext = 0

"""        Anzu

let g:anzu_airline_section = "c"
let g:anzu_status_format = "[%i/%l]"

"""        Goyo

let g:goyo_width = 81

""    General Mappings
"""        Toggles

" Toggle / close / open Undotree
nnoremap you :UndotreeToggle<cr>
nnoremap [ou :UndotreeShow<cr>
nnoremap ]ou :UndotreeHide<cr>
nnoremap yo<c-u> :UndotreeFocus<cr>

" Switch dark / light theme[
nnoremap <silent> yob :call DarkLightSwitch()<cr>

" Netrw toggle - left
nnoremap <silent> yoe :40Lexplore<cr>

" Toggle of hlsearch + Anzu
nnoremap <silent> yoh :call anzu#clear_search_status()<cr>:nohlsearch<cr>

" Toggle terminal - bottom
nnoremap <silent> yot :call <SID>ToggleTerminal('J', 6)<CR>

" Toggle terminal - right
nnoremap <silent> yo<c-t> :call <SID>ToggleTerminal('L', 60)<CR>

" Toggle terminal - right
nnoremap <silent> yoT :call <SID>PopupTerminal()<CR>

" Toggle keep cursor in middle of screen
nnoremap <silent> yoz :let &scrolloff=999-&scrolloff<cr>

" Load project files buffers
nnoremap yoj :call AutoProjectLoad('1')<cr>

"""        Copy / Paste / Delete

" delete without saving to register
nnoremap <leader>d "_d
xnoremap <leader>d "_d
" xnoremap <leader>p "_dP

" paste with indentation
" nnoremap P mp]P==`p
" nnoremap p mp]p==`p

" System clipboard interraction
" paste from clipboard ...
nnoremap <leader>p mp"+]p==`p
nnoremap <leader>P mp"+]P==`p
" ... on new line ...
nnoremap <leader>op o<esc>"+]p==
" ... above
nnoremap <leader>oP O<esc>"+]p==
nnoremap <leader>Op O<esc>"+]p==
nnoremap <leader>OP O<esc>"+]p==

" copy to clipboard
nnoremap <leader>y "+y
nnoremap <leader>yl "+y$
nnoremap <leader>yh "+y^
vnoremap <leader>y "+y

"""        Replace

" Replace last search
nnoremap gr :s/<c-r>///g<left><left>
vnoremap gr :s/<c-r>///g<left><left>
nnoremap gR :%s/<c-r>///g<left><left>
nnoremap c/ :s///g<left><left>
vnoremap c/ :s///g<left><left>
nnoremap C/ :%s///g<left><left>

" Replace word under cursor
nnoremap c. :s/<c-r><c-w>//g<left><left>
vnoremap c. :s/<c-r><c-w>//g<left><left>
nnoremap C. :%s/<c-r><c-w>//g<left><left>

nnoremap C <nop>

"""        Files Informations

" cd shell to vim current working directory
nnoremap <leader>cd :!cd &pwd<cr> :echo "shell cd : " . getcwd()<cr>

" show file name
nnoremap <leader>fp :echo expand('%')<cr>

" show file path/name and copy it to unnamed register
nnoremap <leader>fP :let @"=expand('%:p')<cr>:echo expand('%:p')<cr>

" show file name and copy it to unnamed register
nnoremap <leader>f<c-p> :let @"=expand('%')<cr>:echo expand('%:p:h')<cr>

" new file here
nnoremap <leader>nn :e <c-r>=expand('%:p:h') . '/'<cr>
nnoremap <leader>nv :vs <c-r>=expand('%:p:h') . '/'<cr>
nnoremap <leader><c-n> :vs <c-r>=expand('%:p:h') . '/'<cr>

" Word count
function! WordCount() abort
  echo system("detex " . expand("%") . " | wc -w | tr -d [[:space:]]") "words"
endfunction

nnoremap <leader>wcc :call WordCount()<cr>
" nnoremap <leader>w :w !detex \| wc -w<cr>

" new file in vertical split instead of horizontal
nnoremap <c-w><c-n> :vertical new<cr>

" open file under cursor in vertical split instead of horizontal
nnoremap <c-w><c-f> :vertical wincmd f<cr>

" open file under cursor in a netrw pannel on the left
nnoremap <c-w><c-d> :Lexplore <cfile><cr>

"""        Folding

" Open / close fold with <c-space>
if ! has("nvim")
  nnoremap <c-@> za
  onoremap <c-@> <c-c>za
  vnoremap <c-@> zf
elseif has("nvim")
  nnoremap <c-space> za
  onoremap <c-space> <c-c>za
  vnoremap <c-space> zf
endif

" close every fold except current
nnoremap <leader>zc :normal! mzzMzv`z<CR>

" recursively open even partial folds
nnoremap zo zczO

"""        Dotfiles

" source vimrc
nnoremap <leader>sv mZ:source $MYVIMRC<cr>:silent doautocmd BufRead<cr>:nohlsearch<cr>:echo "vimrc sourced"<cr>`Zzz
nnoremap <leader>ss mZ:source $MYVIMRC<cr>:nohlsearch<cr>:redraw<cr>:doautocmd BufRead<cr>:echo "all fresh"<cr>`Zzz

" source colors
nnoremap <silent> <leader>s1 :source $HOME/.vim/colors/base16-onedark.vim<cr>
nnoremap <silent> <leader>s2 :source $HOME/.vim/colors/base16-one-light.vim<cr>

" edit dotfiles
nnoremap <leader>ev :e $HOME/dotfiles/vimrc<cr>
nnoremap <leader>e<c-v> :vertical split $HOME/dotfiles/vimrc<cr>
nnoremap <leader>et :e $HOME/dotfiles/tmux.conf<cr>
nnoremap <leader>e<c-t> :vertical split $HOME/dotfiles/tmux.conf<cr>
nnoremap <leader>eb :e $HOME/dotfiles/bashrc<cr>
nnoremap <leader>e<c-b> :vertical split $HOME/dotfiles/bashrc<cr>
nnoremap <leader>ea :e $HOME/dotfiles/bash_aliases<cr>
nnoremap <leader>e<c-a> :vertical split $HOME/dotfiles/bash_aliases<cr>
nnoremap <leader>en :e $HOME/dotfiles/inputrc<cr>
nnoremap <leader>e<c-n> :vertical split $HOME/dotfiles/inputrc<cr>
nnoremap <leader>ep :e $HOME/dotfiles/bash_profile<cr>
nnoremap <leader>e<c-p> :vertical split $HOME/dotfiles/bash_profile<cr>
nnoremap <leader>ec1 :e $HOME/dotfiles/vim/colors/base16-onedark.vim<cr>
nnoremap <leader>ec2 :e $HOME/dotfiles/vim/colors/base16-one-light.vim<cr>
nnoremap <leader>eo :CocConfig<cr>
nnoremap <leader>e<c-o> :vs <bar> CocConfig<cr>

" " rename file
" nnoremap <leader>mv :!mv % %:h:p/

"""        Git

" Show git log history
nnoremap <leader>gl :vert terminal git --no-pager log --all --decorate --oneline --graph<cr>:setlocal filename=""<cr>
" Show git log in location list
nnoremap ghl :Gllog! <bar> wincmd b <bar> wincmd L<cr>

"""        Terminal

tnoremap <c-n> <c-\><c-n>
tnoremap <c-w>; <c-w>:

""    Move Mappings
"""        Modes

" space as leader, prompt '\' in command line window :)
map <space> <leader>

" closing easy
nnoremap <leader>q :quit<cr>

nnoremap <leader><c-@> :echo "kewl"<cr>

" enter command mode with ;
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
nnoremap <leader>; :!

nnoremap gI `.gi<esc>zz

" no more default ex mode
nnoremap Q <nul>

" redraw
nnoremap <c-q> :redraw!<cr>

" repeat last macro
nnoremap - @@

" <c-z> in insert and command mode
inoremap <c-z> <c-[><c-z>
cnoremap <c-z> <c-[><c-z>

" <c-s> save and enter normal mode
function! VerboseUpdate() abort
  update
  echo(':update '.expand('%'))
endfunction

nnoremap <c-s> :call VerboseUpdate()<cr>
vnoremap <c-s> :call VerboseUpdate()<cr>
inoremap <c-s> <esc>:call VerboseUpdate()<cr>

" :W! save files as root
cnoremap <c-r><c-s> %!sudo tee > /dev/null %

"""        Movement

" insert mode delete
inoremap <c-l> <c-o>x

" up down on visual lines
nnoremap <silent> j gj
nnoremap <silent> k gk
xnoremap <silent> j gj
xnoremap <silent> k gk

nnoremap <expr> <c-l> getline(".")[col(".")] == ' ' <bar><bar> getline(".")[col(".") - 1] == ' ' ? "w" : "E"
vnoremap <expr> <c-l> getline(".")[col(".")] == ' ' <bar><bar> getline(".")[col(".") - 1] == ' ' ? "w" : "E"
nnoremap <expr> <c-h> getline(".")[col(".") - 2] == ' ' <bar><bar> getline(".")[col(".") - 1] == ' ' ? "gE" : "B"
vnoremap <expr> <c-h> getline(".")[col(".") - 2] == ' ' <bar><bar> getline(".")[col(".") - 1] == ' ' ? "gE" : "B"

nnoremap H ^
nnoremap L $
nnoremap <c-k> {
nnoremap <c-j> }

vnoremap H ^
vnoremap L g_
vnoremap <c-k> {
vnoremap <c-j> }

"go to next / previous buffer
nnoremap <leader>] :bn<cr>
nnoremap <leader>[ :bp<cr>

" switch last 2 buffers
nnoremap <leader><space> <c-^>
onoremap <leader><space> <c-^>
vnoremap <leader><space> <c-^>

" last buffer in vertical split
nnoremap <c-w><space><space> :vertical split #<cr>
onoremap <c-w><space><space> :vertical split #<cr>
vnoremap <c-w><space><space> :vertical split #<cr>

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" open buffer with partial search
" nnoremap <leader>b :buffer<space>
" nnoremap <leader><c-b> :vertical sbuffer<space>
" nnoremap <leader>B :sbuffer<space>
" nnoremap <leader>T :vertical sbuffer !/bin/bash<cr>

"""        Alt Movement

" Allow <alt> key mappings
if ! has("nvim")
  let c='a'
  while c <= 'z'
    let d=toupper(c)
    exec "set <M-".c.">=\e".c
    exec "imap \e".c." <M-".c.">"
    exec "set <M-".d.">=\e".d
    exec "imap \e".d." <M-".d.">"
    let c = nr2char(1+char2nr(c))
  endw

  exe "set <F31>=\eh"
  exe "set <F32>=\ej"
  exe "set <F33>=\ek"
  exe "set <F34>=\el"

  inoremap <F31> <left>
  inoremap <F32> <down>
  inoremap <F33> <up>
  inoremap <F34> <right>

  nnoremap <silent> <F31> :wincmd h<cr>
  nnoremap <silent> <F32> :wincmd j<cr>
  nnoremap <silent> <F33> :wincmd k<cr>
  nnoremap <silent> <F34> :wincmd l<cr>

  tnoremap <silent> <F31> <c-\><c-n>:wincmd k<cr>
  tnoremap <silent> <F32> <c-\><c-n>:wincmd j<cr>
  tnoremap <silent> <F33> <c-\><c-n>:wincmd l<cr>
  tnoremap <silent> <F34> <c-\><c-n>:wincmd h<cr>

  cnoremap <F31> <left>
  cnoremap <F32> <down>
  cnoremap <F33> <up>
  cnoremap <F34> <right>

else

  inoremap <M-h> <left>
  inoremap <M-j> <down>
  inoremap <M-k> <up>
  inoremap <M-l> <right>

  " execute "set <M-j>=^[j"
  nnoremap <silent> <M-K> :exe "resize +1"<cr>
  nnoremap <silent> <M-J> :exe "resize -1"<cr>
  nnoremap <silent> <M-L> :exe "vertical resize +1"<CR>
  nnoremap <silent> <M-H> :exe "vertical resize -1"<CR>

  nnoremap <silent> <M-k> :wincmd k<cr>
  nnoremap <silent> <M-j> :wincmd j<cr>
  nnoremap <silent> <M-l> :wincmd l<cr>
  nnoremap <silent> <M-h> :wincmd h<cr>

  tnoremap <silent> <M-k> <c-\><c-n>:wincmd k<cr>
  tnoremap <silent> <M-j> <c-\><c-n>:wincmd j<cr>
  tnoremap <silent> <M-l> <c-\><c-n>:wincmd l<cr>
  tnoremap <silent> <M-h> <c-\><c-n>:wincmd h<cr>

  cnoremap <M-h> <left>
  cnoremap <M-j> <down>
  cnoremap <M-k> <up>
  cnoremap <M-l> <right>

endif

" resize windows quicker
nnoremap <leader>= :exe "resize +10"<cr>
nnoremap <leader>- :exe "resize -10"<cr>
nnoremap <leader>> :exe "vertical resize +10"<CR>
nnoremap <leader>< :exe "vertical resize -10"<CR>

nnoremap <silent> <M-K> :exe "resize +1"<cr>
nnoremap <silent> <M-J> :exe "resize -1"<cr>
nnoremap <silent> <M-L> :exe "vertical resize +1"<CR>
nnoremap <silent> <M-H> :exe "vertical resize -1"<CR>

"""        Searching

" Pair cycle
nnoremap <c-g> %

" n and N not reversed in reverse-search
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]

nnoremap / :call clearmatches()<cr>/
nnoremap <leader>/ :call clearmatches()<cr>/\v
vnoremap <leader>/ :call clearmatches()<cr>/\v

nnoremap zM zMzb
nnoremap <silent> zm :set scrolloff=0<cr>zmzb:let &scrolloff=winheight(win_getid())/10 + 1<cr>
nnoremap <silent> zb :set scrolloff=0<cr>zb:let &scrolloff=winheight(win_getid())/10 + 1<cr>
" " nnoremap za zazz
" nnoremap zA zAzz
" nnoremap <leader>za zMzvzz

" search with different highlight
nnoremap <silent> n n:call HLCurrent()<cr>
nnoremap <silent> N N:call HLCurrent()<cr>

"do not move cursor with first match
nnoremap <silent> * :let @/= '\<' . expand('<cword>') . '\>' <bar> set hls <cr>
nnoremap <silent> g* :let @/=expand('<cword>') <bar> set hls <cr>

" search visual selection
vnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>

"""        Command Line

cnoremap <c-a> <Home>
cnoremap <c-e> <End>
cnoremap <c-k> <Up>
cnoremap <c-j> <Down>
cnoremap <c-b> <Left>
" cnoremap <c-f> <Right>
cnoremap <c-l> <S-Right>
cnoremap <c-h> <S-Left>
cnoremap <c-x> <c-h>
cnoremap <c-o> <s-tab>
cnoremap <c-r><c-l> <c-r>=substitute(getline('.'), '^\s*', '', '')<cr>

"""        Tags

" show matching tags
nnoremap g<c-]> g]

" jump if only one match
nnoremap g] g<c-]>

""    Code Mappings
"""        General

" indent all file easy
nnoremap g<c-g> mZgg=G`Z

" Toggle location list (awesome)
nnoremap <expr> <leader>cl get(getloclist(0, {'winid':0}), 'winid', 0) ?
      \ ":lclose<cr>" : ":lopen<cr><c-w>p"

" Toggle quickfix list (awesome)
nnoremap <expr> <leader>cq get(getqflist({'winid':0}), 'winid', 0) ?
      \ ":cclose<cr>" : ":copen<cr><c-w>p"

" trim current line
nnoremap <silent> <leader>xx :s/\s\+$//<cr>:redraw<cr>
"trim file
nnoremap <leader>xX :%s/\s\+$//<cr>:redraw<cr>
nnoremap <leader>XX :%s/\s\+$//<cr>:redraw<cr>

" Make
nnoremap <leader>cm :make<cr><cr>
nnoremap <leader>cr :make re<cr><cr>
nnoremap <leader>ce :make ex<cr><cr>
nnoremap <leader>ct :make ex TESTFF=test/test*<cr><cr>
nnoremap <leader>cT :make ex TESTFF=
nnoremap <leader>c<c-t> :make ex TEST=test/%<cr><cr>

function! LocListPannel(pfx) abort
  " if a:pfx == 'l' && len(getloclist(0)) == 0
  "   echohl ErrorMsg
  "   echo "Location List is Empty."
  "   return
  " endif
  let winnr = winnr()
  exec(a:pfx.'open')
  wincmd L
  if winnr() != winnr
    wincmd p
  endif
endfunction

" Make in spit
nnoremap <leader>csm :lmake!<cr>:call LocListPannel('l')<cr>

nnoremap <leader>csr :lmake! re<cr>:call LocListPannel('l')<cr>
nnoremap <leader>cse :Shell make ex<cr><cr>
nnoremap <leader>cst :Shell make ex TESTFF=test/test*<cr><cr>
nnoremap <leader>c<c-s><c-t> :VShell make ex TESTFF=test/test*<cr><cr>
nnoremap <leader>c<c-s>t :VShell make ex TESTFF=test/test*<cr><cr>
nnoremap <leader>cs<c-t> :VShell make ex TESTFF=test/test*<cr><cr>
nnoremap <leader>cs<c-t> :VShell make ex TEST=test/%<cr><cr>
nnoremap <leader>csT :Shell make ex TESTFF=
" nnoremap <leader>csv :Shell make ex TEST=<cr><cr>
" nnoremap <leader>csm :make<cr><cr>:lopen<cr>:wincmd L<cr>

" nnoremap <leader>csm :lmake<cr>:lopen<cr>:wincmd L<cr>
" nnoremap <leader>csr :lmake re<cr>:lopen<cr>:wincmd L<cr>
" nnoremap <leader>cse :lmake ex<cr><cr>:lopen<cr>:wincmd L<cr>
" nnoremap <leader>cst :lmake ex TESTFF=test/test*<cr><cr>:lopen<cr>:wincmd L<cr>
" nnoremap <leader>cs<c-t> :lmake ex TEST=test/%<cr><cr>:lopen<cr>:wincmd L<cr>
" nnoremap <leader>csT :lmake ex TESTFF=:lopen<cr>:wincmd L<cr>
" " nnoremap <leader>csv :make ex TEST=<cr><cr>:lopen<cr>:wincmd L<cr>
" nnoremap <leader>csm :lmake<cr><cr>:lopen<cr>:wincmd L<cr>

" Count line in function
function! FunctionLineCount() abort
  let firstline = search('^{', 'bn')
  let lastline = search('^}', 'n')
  echo "function lines :" lastline - firstline - 1
endfunction

nnoremap <leader>wcf :call FunctionLineCount()<cr>

"""        Coc

" fix error when using tabs in middle of line
if v:version < 802
  inoremap <c-i> <c-v><c-i>
endif

if ! has("nvim")
  inoremap <expr> <c-@> pumvisible() ? coc#_select_confirm() : coc#refresh()
elseif has("nvim")
  inoremap <expr> <c-space> pumvisible() ? coc#_select_confirm() : coc#refresh()
endif

inoremap <expr> <c-j> pumvisible() ? "\<C-n>" : coc#refresh()
inoremap <expr> <c-k> pumvisible() ? "\<C-p>" : coc#refresh()
hi link CocHilightText Visual

" inoremap <expr> <c-n> pumvisible() ? "\<C-p>" : coc#refresh()
let g:coc_snippet_next = '<c-f>'
let g:coc_snippet_prev = '<c-b>'

" use tab as in VSCode
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? coc#_select_confirm() :
"       \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()

" function text object mappings
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" pmenu mappings
nmap <silent> <leader>gf <Plug>(coc-definition)
nmap <silent> <leader>gd <Plug>(coc-declaration)
nmap <silent> <leader>gt <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> [w <Plug>(coc-diagnostic-prev)
nmap <silent> ]w <Plug>(coc-diagnostic-next)
nmap <leader>cf  <Plug>(coc-fix-current)

" rename word
nmap <leader>rn <Plug>(coc-rename)

" show doc with Coc
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation() abort
  if index(['vim','help'], &filetype) >= 0
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold (K)
augroup CocHiglightSymbol
  au!
  au CursorHold * silent call CocActionAsync('highlight')
augroup end

augroup CocFormatAndK
  au!
  " Setup formatexpr specified filetype(s).
  au FileType typescript,json setlocal formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  au User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction

let g:markdown_fenced_languages = ['css', 'js=javascript']

" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"""        bash

inoremap <expr> ! (&filetype == '' <bar><bar> &filetype == 'sh') && col('.') == 2 && getline('.') =~ "^#" ? "!/bin/bash" : "!"

augroup Shmaps
  au!
  au FileType sh inoremap <buffer> <expr> ! col('.') == 2 && getline('.') =~ "^#" ? "!/bin/bash" : "!"
  au FileType sh inoremap <buffer> ,#! #!/bin/bash

  " alias to function
  au FileType sh nnoremap <buffer> <leader>xf ^dWf=2s() {<cr><esc>$x==o}<esc>

  " auto close brackets
  au FileType sh inoremap <buffer> { {}<c-g>U<left>
  au FileType sh inoremap <buffer> <expr> <cr> getline('.')[col('.')-2:col('.')-1]=='{}' ? '<cr><esc>O' : '<cr>'
  au FileType sh inoremap <buffer> <expr> } getline('.')[col('.')-1]=='}' ? '<c-g>U<right>' : '}'

augroup end

"""        C

augroup Cmaps
  au!
  au FileType c,cpp inoremap <buffer> ,ma <esc>:Header101<cr>iint<tab><tab>main(int ac, char **av)<cr>{<cr>}<esc>Oreturn(0);<esc>O
  au FileType c,cpp inoremap <buffer> ,if if ()<cr>{<cr>}<esc>2k3==f)i
  au FileType c,cpp inoremap <buffer> ,wh while ()<cr>{<cr>}<esc>2k3==f)i
  au FileType c,cpp inoremap <buffer> ,ret return (0);<esc>^
  au FileType c,cpp inoremap <buffer> ,imin -2147483648
  au FileType c,cpp inoremap <buffer> ,imax 2147483647
  au FileType c,cpp inoremap <buffer> ,endl ft_putendl("");<left><left><left>
  au FileType c,cpp inoremap <buffer> ,str ft_putstr("");<left><left><left>
  au FileType c,cpp inoremap <buffer> ,nbr ft_putnbr();<cr>ft_putendl("");<up><left><left>
  au FileType c,cpp inoremap <buffer> ,lib #include <stdlib.h><cr>#include <unistd.h><cr>#include <stdio.h><cr>#include <sys/types.h><cr>#include <sys/wait.h><cr>#include <sys/types.h><cr>#include <sys/stat.h><cr>#include <fcntl.h><cr>#include <string.h><cr>#include <bsd/string.h><cr>

  au FileType c,cpp nnoremap <buffer> <leader><c-]> <c-w>v<c-]>z<cr>
  " if to ternary operator
  au FileType c,cpp nnoremap <buffer> <leader>xt $Ji<space>?<esc>$i : 0<esc>^dw
  au FileType c,cpp nnoremap <buffer> <leader>xT ^iif<space>(<esc>f?h3s)<cr><esc>f:h3s;<cr>else<cr><esc>
  au FileType c,cpp nnoremap <buffer> <leader>x<c-t> ^iif<space>(<esc>f?h3s)<cr><esc>f:hc$;<esc>

  " compile and execute current
  au FileType c,cpp nnoremap <buffer> <leader>cc :!gcc -Wall -Wextra % && ./a.out<cr>
  au FileType c,cpp nnoremap <buffer> <leader>cC :!gcc -Wall -Wextra % && ./a.out
  au FileType c,cpp nnoremap <buffer> <leader>csc :Shell gcc -Wall -Wextra % && ./a.out<cr>
  au FileType c,cpp nnoremap <buffer> <leader>cs<c-m> :Shell gcc -Wall -Wextra % main.c && ./a.out<cr>

  " auto close brackets
  au FileType c,cpp inoremap <buffer> { {}<c-g>U<left>
  au FileType c,cpp inoremap <buffer> <expr> <cr> getline('.')[col('.')-2:col('.')-1]=='{}' ? '<cr><esc>O' : '<cr>'
  au FileType c,cpp inoremap <buffer> <expr> } getline('.')[col('.')-1]=='}' ? '<c-g>U<right>' : '}'

  " brackets around paragraph
  au FileType c,cpp nnoremap <buffer> <leader>{} mZ{S{<esc>}S}<esc>=%`Z=iB
  au FileType c,cpp nnoremap <buffer> <leader>{{ o}<esc>kO{<esc>3==j

  "  name of current c,cpp function (needs '()')
  au FileType c,cpp nnoremap <buffer> <silent> g<c-d> ][[[h^t(b

  " semicolon/coma EOL toggle
  au FileType c,cpp nnoremap <buffer> <expr> <leader>; getline('.')[col('$') - 2] == ';' ? "mZ$x`Z" : "mZA;\<esc>`Z"
  au FileType c,cpp nnoremap <buffer> <expr> <leader>, getline('.')[col('$') - 2] == ',' ? "mZ$x`Z" : "mZA,\<esc>`Z"

  " select all text in function
  au FileType c,cpp nnoremap <buffer> <leader>vf j[[V%o

  " valgrind
  au FileType c,cpp nnoremap <buffer> <leader>cv :!valgrind ./test.out 2> /dev/null<cr><cr>
  au FileType c,cpp nnoremap <buffer> <leader>csv :Shell valgrind ./test.out 2> /dev/null<cr><cr>
augroup end

" nnoremap viB [[%v%jok$
" nnoremap vaB [[%v%
" " nnoremap vib [{%v%jok$
" nnoremap vab [{%v%

" " Commenting blocks of code.
" au FileType c,cpp,java,scala let b:com_size = '3' | let b:com = '// '
" au FileType sh,ruby,python   let b:com_size = '2' | let b:com = '# '
" au FileType conf,fstab       let b:com_size = '2' | let b:com = '# '
" au FileType tex              let b:com_size = '2' | let b:com = '% '
" au FileType mail             let b:com_size = '2' | let b:com = '> '
" au FileType vim              let b:com_size = '2' | let b:com = '" '
" au FileType readline         let b:com_size = '2' | let b:com = '# '

" nnoremap <silent> <leader>'' m'V:norm i<c-r>=expand(b:com)<cr><cr>`'<right><right>
" vnoremap <silent> <leader>'' m':norm i<c-r>=expand(b:com)<cr><cr>`'

" nnoremap <silent> <leader>"" m'V:norm <c-r>=expand(b:com_size)<cr>x<cr>`'<left><left>
" vnoremap <silent> <leader>"" m':norm <c-r>=expand(b:com_size)<cr>x<cr>`'

" noremap <silent> <leader>'p yypk:<c-b> <c-e>s/^\V<c-r>=escape(b:comment_leader,'\/')<cr>//e<cr>:nohlsearch<cr>

"""        Java

augroup JavaMaps
  au!
  au FileType java,groovy nnoremap <buffer> <leader>cg :Shell gradle run<cr>

  au FileType java,groovy inoremap <buffer> ,if if ()<cr>{<cr>}<c-o>2<up><c-o>f)
  au FileType java,groovy inoremap <buffer> ,wh while ()<cr>{<cr>}<c-o>2<up><c-o>f)
  au FileType java,groovy inoremap <buffer> ,imin -2147483648
  au FileType java,groovy inoremap <buffer> ,imax 2147483647

  au FileType java,groovy nnoremap <buffer> <leader><c-]> <c-w>v<c-]>z<cr>
  " if to ternary operator
  au FileType java,groovy nnoremap <buffer> <leader>xt $Ji<space>?<esc>$i : 0<esc>^dw
  au FileType java,groovy nnoremap <buffer> <leader>xT ^iif<space>(<esc>f?h3s)<cr><esc>f:h3s;<cr>else<cr><esc>
  au FileType java,groovy nnoremap <buffer> <leader>x<c-t> ^iif<space>(<esc>f?h3s)<cr><esc>f:hc$;<esc>

  " auto close brackets
  au FileType java,groovy inoremap <buffer> { {}<c-g>U<left>
  au FileType java,groovy inoremap <buffer> <expr> <cr> getline('.')[col('.')-2:col('.')-1]=='{}' ? '<cr><esc>O' : '<cr>'
  au FileType java,groovy inoremap <buffer> <expr> } getline('.')[col('.')-1]=='}' ? '<c-g>U<right>' : '}'

  " brackets auround paragraph
  au FileType java,groovy nnoremap <buffer> <leader>{} mZ{S{<esc>}S}<esc>=%`Z=iB
  au FileType java,groovy nnoremap <buffer> <leader>{{ o}<esc>kO{<esc>3==j

  "  name of current function (needs '()')
  au FileType java,groovy nnoremap <buffer> <silent> g<c-d> ][[[h^t(b

  " semicolon/coma EOL toggle
  au FileType java,groovy nnoremap <buffer> <expr> <leader>; getline('.')[col('$') - 2] == ';' ? "mZ$x`Z" : "mZA;\<esc>`Z"
  au FileType java,groovy nnoremap <buffer> <expr> <leader>, getline('.')[col('$') - 2] == ',' ? "mZ$x`Z" : "mZA,\<esc>`Z"

  " select allext in function
  au FileType java,groovy nnoremap <buffer> <leader>vf j[[V%o
augroup end

" nnoremap viB [[%v%jok$
" nnoremap vaB [[%v%
" " nnoremap vib [{%v%jok$
" nnoremap vab [{%v%

" " Commenting blocks of code.
" au FileType c,cpp,java,scala let b:com_size = '3' | let b:com = '// '
" au FileType sh,ruby,python   let b:com_size = '2' | let b:com = '# '
" au FileType conf,fstab       let b:com_size = '2' | let b:com = '# '
" au FileType tex              let b:com_size = '2' | let b:com = '% '
" au FileType mail             let b:com_size = '2' | let b:com = '> '
" au FileType vim              let b:com_size = '2' | let b:com = '" '
" au FileType readline         let b:com_size = '2' | let b:com = '# '

" nnoremap <silent> <leader>'' m'V:norm i<c-r>=expand(b:com)<cr><cr>`'<right><right>
" vnoremap <silent> <leader>'' m':norm i<c-r>=expand(b:com)<cr><cr>`'

" nnoremap <silent> <leader>"" m'V:norm <c-r>=expand(b:com_size)<cr>x<cr>`'<left><left>
" vnoremap <silent> <leader>"" m':norm <c-r>=expand(b:com_size)<cr>x<cr>`'

" noremap <silent> <leader>'p yypk:<c-b> <c-e>s/^\V<c-r>=escape(b:comment_leader,'\/')<cr>//e<cr>:nohlsearch<cr>

"""        JavaScript

augroup JSmaps
  au!
  au FileType javascript nnoremap <buffer> <leader>cr :Run<cr>
  au FileType javascript nnoremap <buffer> <leader>ca :AutoRun<cr>
  au FileType javascript nnoremap <buffer> <leader>; i<c-o>mZ<c-o>A;<esc>`Z<esc>
  au FileType javascript nnoremap <buffer> <leader>, i<c-o>mZ<c-o>A,<esc>`Z<esc>
  au FileType javascript nnoremap <buffer> <leader>cc :Shell node %<cr>
  au FileType javascript nnoremap <buffer> <leader>ls :!live-server %<cr>
  au FileType javascript inoremap <buffer> ,if if ()<cr>{<cr>}<esc>2k3==f)i
  au FileType javascript inoremap <buffer> ,fo for ()<cr>{<cr>}<esc>2k3==f)i
  au FileType javascript inoremap <buffer> ,wh while ()<cr>{<cr>}<esc>2k3==f)i
  au FileType javascript inoremap <buffer> ,cl console.log();<esc>F)i
  au FileType javascript nnoremap <buffer> <leader>xl yiwoconsole.log();<esc>F(p
  au FileType javascript vnoremap <buffer> <leader>xl yoconsole.log();<esc>F(p

  " auto close brackets
  au FileType javascript inoremap <buffer> { {}<c-g>U<left>
  au FileType javascript inoremap <buffer> <expr> <cr> getline('.')[col('.')-2:col('.')-1]=='{}' ? '<cr><esc>O' : '<cr>'
  au FileType javascript inoremap <buffer> <expr> } getline('.')[col('.')-1]=='}' ? '<c-g>U<right>' : '}'

augroup end

"""        Json

augroup Jsonmaps
  au!
  au FileType json nnoremap <buffer> <expr> <leader>; getline('.')[col('$') - 2] == ';' ? "mZ$x`Z" : "mZA;\<esc>`Z"
  au FileType json nnoremap <buffer> <expr> <leader>, getline('.')[col('$') - 2] == ',' ? "mZ$x`Z" : "mZA,\<esc>`Z"

  " auto close brackets
  au FileType json inoremap <buffer> { {}<c-g>U<left>
  au FileType json inoremap <buffer> <expr> <cr> getline('.')[col('.')-2:col('.')-1]=='{}' ? '<cr><esc>O' : '<cr>'
  au FileType json inoremap <buffer> <expr> } getline('.')[col('.')-1]=='}' ? '<c-g>U<right>' : '}'

augroup end

"""        PHP/HTML/CSS

augroup Webmaps
  au!
  au FileType php,html,json nnoremap <buffer> <leader>xst ciw<strong><c-o>P</strong><esc>T<
  au FileType php,html,json nnoremap <buffer> <leader>xst ciw<em><c-o>P</em><esc>T<

  au FileType css nnoremap <buffer> <c-w>u :40 wincmd\|<cr>

  " auto close brackets
  au FileType css inoremap <buffer> { {}<c-g>U<left>
  au FileType css inoremap <buffer> <expr> <cr> getline('.')[col('.')-2:col('.')-1]=='{}' ? '<cr><esc>O' : '<cr>'
  au FileType css inoremap <buffer> <expr> } getline('.')[col('.')-1]=='}' ? '<c-g>U<right>' : '}'

  au FileType php,html inoremap <buffer> ,php <?php<cr>?><esc>O
  au FileType php,html inoremap <buffer> ,bo <body></body><esc>F<i
  au FileType php,html inoremap <buffer> ,h1 <h1></h1><esc>F<i
  au FileType php,html inoremap <buffer> ,h2 <h2></h2><esc>F<i
  au FileType php,html inoremap <buffer> ,h3 <h3></h3><esc>F<i
  au FileType php,html inoremap <buffer> ,h4 <h4></h4><esc>F<i
  au FileType php,html inoremap <buffer> ,h5 <h5></h5><esc>F<i
  au FileType php,html inoremap <buffer> ,h6 <h6></h6><esc>F<i
  au FileType php,html inoremap <buffer> ,pp <p></p><esc>F<i
  au FileType php,html inoremap <buffer> ,br <br/>
  au FileType php,html inoremap <buffer> ,aa <a href="" alt=""></a><esc>F<i
  au FileType php,html inoremap <buffer> ,img <img src="" alt=""></img><esc>F<i
  au FileType php,html inoremap <buffer> ,uu <u></u><esc>F<i
  au FileType php,html inoremap <buffer> ,ii <i></i><esc>F<i
  au FileType php,html inoremap <buffer> ,bb <b></b><esc>F<i
  au FileType php,html inoremap <buffer> ,sk <strike></strike><esc>F<i
  au FileType php,html inoremap <buffer> ,sup <sup></sup><esc>F<i
  au FileType php,html inoremap <buffer> ,sub <sub></sub><esc>F<i
  au FileType php,html inoremap <buffer> ,sm <small></small><esc>F<i
  au FileType php,html inoremap <buffer> ,tt <tt></tt><esc>F<i
  au FileType php,html inoremap <buffer> ,pre <pre></pre><esc>F<i
  au FileType php,html inoremap <buffer> ,bq <blockquote></blockquote><esc>F<i
  au FileType php,html inoremap <buffer> ,st <strong></strong><esc>F<i
  au FileType php,html inoremap <buffer> ,em <em></em><esc>F<i
  au FileType php,html inoremap <buffer> ,ol <ol></ol><esc>F<i
  au FileType php,html inoremap <buffer> ,dd <dd></dd><esc>F<i
  au FileType php,html inoremap <buffer> ,dt <dt></dt><esc>F<i
  au FileType php,html inoremap <buffer> ,dl <dl></dl><esc>F<i
  au FileType php,html inoremap <buffer> ,ul <ul></ul><esc>F<i
  au FileType php,html inoremap <buffer> ,li <li></li><esc>F<i
  au FileType php,html inoremap <buffer> ,hr <hr></hr><esc>F<i
  au FileType php,html inoremap <buffer> ,di <div></div><esc>F<i
  au FileType php,html inoremap <buffer> ,sp <span></span><esc>F<i
  au FileType php,html inoremap <buffer> ,se <select></select><esc>F<i
  au FileType php,html inoremap <buffer> ,op <optionlect></optionlect><esc>F<i
  au FileType php,html inoremap <buffer> ,tx <textarealect></textarealect><esc>F<i

  au FileType php,html inoremap <buffer> ,fo <form action="" method=""><return><input type="text" name=""><return></form>
  au FileType php,html inoremap <buffer> ,fg <form action="" method="get"><return><input type="text" name=""><return></form>
  au FileType php,html inoremap <buffer> ,fp <form action="" method="post"><return><input type="text" name=""><return></form>
  au FileType php,html inoremap <buffer> ,in <input type="" name="" value=""></input><esc>F<i

  au FileType php,html inoremap <buffer> ,ec echo "";<esc>hi
  au FileType php,html inoremap <buffer> ,ge $_GET[""]<esc>hi
  au FileType php,html inoremap <buffer> ,po $_POST[""]<esc>hi
  au FileType php,html inoremap <buffer> ,lorem Lorem ipsum dolor sit amet,
        \ consectetuer adipiscing elit, sed diam nonummy nibh
        \ euismod tincidunt ut laoreet dolore magna aliquam erat
        \ volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci
        \ tation ullamcorper suscipit lobortis nisl ut aliquip ex ea
        \ commodo consequat. Duis autem vel eum iriure dolor in
        \ hendrerit in vulputate velit esse molestie consequat, vel
        \ illum dolore eu feugiat nulla facilisis at vero eros et
        \ accumsan et iusto odio dignissim qui blandit praesent
        \ luptatum zzril delenit augue duis dolore te feugait nulla
        \ facilisi.

  au FileType php,html nnoremap <leader>; i<c-o>mZ<c-o>A;<esc>`Z<esc>
  au FileType php,html nnoremap <leader>, i<c-o>mZ<c-o>A,<esc>`Z<esc>
augroup end

"""        LATEX

augroup LatexSmith
  au!
  " Navigating with guides
  au FileType plaintex,tex silent inoremap <buffer> ,, <esc>/<++><cr>"_4s
  au FileType plaintex,tex silent vnoremap <buffer> ,, <esc>/<++><cr>"_4s
  au FileType plaintex,tex silent map <buffer> ,, <esc>/<++><cr>"_4s

  au FileType plaintex,tex silent nnoremap <buffer> <leader>ll :LLPStartPreview

  " Latex snippets
  au FileType plaintex,tex inoremap <buffer> ,fr \begin{frame}<Enter>\frametitle{}<Enter><Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++><esc>6kf}i
  au FileType plaintex,tex inoremap <buffer> ,fi \begin{fitch}<Enter><Enter>\end{fitch}<Enter><Enter><++><esc>3kA
  au FileType plaintex,tex inoremap <buffer> ,exe \begin{exe}<Enter>\ex<space><Enter>\end{exe}<Enter><Enter><++><esc>3kA
  au FileType plaintex,tex inoremap <buffer> ,em \emph{}<++><esc>T{i
  au FileType plaintex,tex inoremap <buffer> ,bf \textbf{}<++><esc>T{i
  au FileType plaintex,tex vnoremap <buffer> , <ESC>`<i\{<ESC>`>2la}<ESC>?\\{<Enter>a
  au FileType plaintex,tex inoremap <buffer> ,it \textit{}<++><esc>T{i
  au FileType plaintex,tex inoremap <buffer> ,ct \textcite{}<++><esc>T{i
  au FileType plaintex,tex inoremap <buffer> ,cp \parencite{}<++><esc>T{i
  au FileType plaintex,tex inoremap <buffer> ,glos {\gll<space><++><space>\\<Enter><++><space>\\<Enter>\trans{``<++>''}}<esc>2k2bcw
  au FileType plaintex,tex inoremap <buffer> ,x \begin{xlist}<Enter>\ex<space><Enter>\end{xlist}<esc>kA<space>
  au FileType plaintex,tex inoremap <buffer> ,ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><esc>3kA\item<space>
  au FileType plaintex,tex inoremap <buffer> ,ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><esc>3kA\item<space>
  au FileType plaintex,tex inoremap <buffer> ,li <Enter>\item<space>
  au FileType plaintex,tex inoremap <buffer> ,dc <Enter>\documentclass<space>
  au FileType plaintex,tex inoremap <buffer> ,doc <Enter>\documentation<space>
  au FileType plaintex,tex inoremap <buffer> ,ref \ref{}<space><++><esc>T{i
  au FileType plaintex,tex inoremap <buffer> ,tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><esc>4kA{}<esc>i
  au FileType plaintex,tex inoremap <buffer> ,ot \begin{tableau}<Enter>\inp{<++>}<tab>\const{<++>}<tab><++><Enter><++><Enter>\end{tableau}<Enter><Enter><++><esc>5kA{}<esc>i
  au FileType plaintex,tex inoremap <buffer> ,can \cand{}<tab><++><esc>T{i
  au FileType plaintex,tex inoremap <buffer> ,con \const{}<tab><++><esc>T{i
  au FileType plaintex,tex inoremap <buffer> ,v \vio{}<tab><++><esc>T{i
  au FileType plaintex,tex inoremap <buffer> ,a \href{}{<++>}<space><++><esc>2T{i
  au FileType plaintex,tex inoremap <buffer> ,sc \textsc{}<space><++><esc>T{i
  au FileType plaintex,tex inoremap <buffer> ,chap \chapter{}<Enter><Enter><++><esc>2kf}i
  au FileType plaintex,tex inoremap <buffer> ,sec \section{}<Enter><Enter><++><esc>2kf}i
  au FileType plaintex,tex inoremap <buffer> ,ssec \subsection{}<Enter><Enter><++><esc>2kf}i
  au FileType plaintex,tex inoremap <buffer> ,sssec \subsubsection{}<Enter><Enter><++><esc>2kf}i
  au FileType plaintex,tex inoremap <buffer> ,st <esc>F{i*<esc>f}i
  au FileType plaintex,tex inoremap <buffer> ,beg \begin{}<Enter><++><Enter>\end{}<Enter><Enter><++><esc>4k0f{a
  au FileType plaintex,tex inoremap <buffer> ,up <esc>/usepackage<Enter>o\usepackage{}<esc>i
  au FileType plaintex,tex nnoremap <buffer> ,up /usepackage<Enter>o\usepackage{}<esc>i
  au FileType plaintex,tex inoremap <buffer> ,tt \texttt{}<space><++><esc>T{i
  au FileType plaintex,tex inoremap <buffer> ,bt {\blindtext}
  au FileType plaintex,tex inoremap <buffer> ,nu $\varnothing$
  au FileType plaintex,tex inoremap <buffer> ,col \begin{columns}[T]<Enter>\begin{column}{.5\textwidth}<Enter><Enter>\end{column}<Enter>\begin{column}{.5\textwidth}<Enter><++><Enter>\end{column}<Enter>\end{columns}<esc>5kA
  au FileType plaintex,tex inoremap <buffer> ,rn (\ref{})<++><esc>F}i
augroup end

"""        Markdown

augroup MarkdownMaps
  au!
  " Ignore diacritics/accents when searching
  cnoremap <CR> <C-\>e getcmdtype() =~ '[?/]' ? substitute(getcmdline(), '\a', '[[=\0=]]', 'g'): getcmdline()<CR><CR>
  au FileType markdown nnoremap <buffer> <leader>cr :Run<cr>
  au FileType markdown nnoremap <buffer> <leader>ca :AutoRun<cr>
  " au FileType markdown nnoremap <buffer> <leader>br A<br><esc>
augroup end

"""        Fun

inoremap ,fox The quick brown fox jumps over the lazy dog
inoremap ,abc abcdefghijklmnopqrstuvwxyz
inoremap ,ABC ABCDEFGHIJKLMNOPQRSTUVWXYZ
inoremap ,09 0123456789

""    FileType settings
"""        Vim
augroup VimSettings
  au!
  au FileType vim setlocal tabstop=2 expandtab textwidth=0 softtabstop=2 shiftwidth=2
augroup END

""    Operators
"""        Start / End of line
onoremap h :<c-u>normal! ^<cr>
onoremap l :<c-u>normal! v$h<cr>
onoremap il :<c-u>normal! $v_<cr>

"""        Surroundings
onoremap i. :<c-u>normal! T.vt.<cr>
onoremap a. :<c-u>normal! F.vf.<cr>

onoremap i, :<c-u>normal! T,vt,<cr>
onoremap a, :<c-u>normal! F,vf,<cr>

onoremap i: :<c-u>normal! T:vt:<cr>
onoremap a: :<c-u>normal! F:vf:<cr>

onoremap i; :<c-u>normal! T;vt;<cr>
onoremap a; :<c-u>normal! F;vf;<cr>

onoremap i? :<c-u>normal! T?vt?<cr>
onoremap a? :<c-u>normal! F?vf?<cr>

onoremap i! :<c-u>normal! T!vt!<cr>
onoremap a! :<c-u>normal! F!vf!<cr>

onoremap i- :<c-u>normal! T-vt-<cr>
onoremap a- :<c-u>normal! F-vf-<cr>

onoremap i_ :<c-u>normal! T_vt_<cr>
onoremap a_ :<c-u>normal! F_vf_<cr>

onoremap i/ :<c-u>normal! T/vt/<cr>
onoremap a/ :<c-u>normal! F/vf/<cr>

onoremap i\ :<c-u>normal! T\vt\<cr>
onoremap a\ :<c-u>normal! F\vf\<cr>

onoremap i@ :<c-u>normal! T@vt@<cr>
onoremap a@ :<c-u>normal! F@vf@<cr>

onoremap i* :<c-u>normal! T*vt*<cr>
onoremap a* :<c-u>normal! F*vf*<cr>

onoremap i# :<c-u>normal! T*vt*<cr>
onoremap a# :<c-u>normal! F*vf*<cr>

onoremap i$ :<c-u>normal! T*vt*<cr>
onoremap a$ :<c-u>normal! F*vf*<cr>

onoremap i> :<c-u>normal! T<vt><cr>
onoremap a> :<c-u>normal! F<vf><cr>
onoremap i< :<c-u>normal! T<vt><cr>
onoremap a< :<c-u>normal! F<vf><cr>

" onoremap i| :<c-u>normal! T|vt|<cr>
" onoremap a| :<c-u>normal! F|vf|<cr>

"""        Next Surroundings
onoremap in( :<c-u>normal! f(lvt)<cr>
onoremap in) :<c-u>normal! ()f(lvt)<cr>
onoremap an( :<c-u>normal! f(vf)<cr>
onoremap an) :<c-u>normal! f(vf)<cr>
onoremap iN( :<c-u>normal! F)vT(oh<cr>
onoremap iN) :<c-u>normal! F)vT(oh<cr>
onoremap aN( :<c-u>normal! F(vf)<cr>
onoremap aN) :<c-u>normal! F)vF(<cr>

onoremap in{ :<c-u>normal! f{lvt}<cr>
onoremap in} :<c-u>normal! f{lvt}<cr>
onoremap an{ :<c-u>normal! f{vf}<cr>
onoremap an} :<c-u>normal! f{vf}<cr>
onoremap iN{ :<c-u>normal! F}vT{oh<cr>
onoremap iN} :<c-u>normal! F}vT{oh<cr>
onoremap aN{ :<c-u>normal! F}vF{<cr>
onoremap aN} :<c-u>normal! F}vF{<cr>

onoremap in[ :<c-u>normal! f[lvt]<cr>
onoremap in] :<c-u>normal! f[lvt]<cr>
onoremap an[ :<c-u>normal! f[vf]<cr>
onoremap an] :<c-u>normal! f[vf]<cr>
onoremap iN[ :<c-u>normal! F]vT[oh<cr>
onoremap iN] :<c-u>normal! F]vT[oh<cr>
onoremap aN[ :<c-u>normal! F]vF[<cr>
onoremap aN] :<c-u>normal! F]vF[<cr>

onoremap in< :<c-u>normal! f<lvt><cr>
onoremap in> :<c-u>normal! f<lvt><cr>
onoremap an< :<c-u>normal! f<vf><cr>
onoremap an> :<c-u>normal! f<vf><cr>
onoremap iN< :<c-u>normal! F>vT<oh<cr>
onoremap iN> :<c-u>normal! F>vT<oh<cr>

onoremap aN< :<c-u>normal! F>vF<<cr>
onoremap aN> :<c-u>normal! F>vF<<cr>

onoremap in" :<c-u>normal! f"vi"<cr>
onoremap an" :<c-u>normal! f"va"<cr>
onoremap iN" :<c-u>normal! F"vi"<cr>
onoremap aN" :<c-u>normal! F"va"<cr>

onoremap in' :<c-u>normal! f'vi'<cr>
onoremap an' :<c-u>normal! f'va'<cr>
onoremap iN' :<c-u>normal! F'vi'<cr>
onoremap aN' :<c-u>normal! F'va'<cr>

onoremap in. :<c-u>normal! f.lvt.<cr>
onoremap an. :<c-u>normal! f.vf.<cr>
onoremap iN. :<c-u>normal! F.hvT.<cr>
onoremap aN. :<c-u>normal! F.vF.<cr>

onoremap in- :<c-u>normal! f-lvt-<cr>
onoremap an- :<c-u>normal! f-vf-<cr>
onoremap iN- :<c-u>normal! F-hvT-<cr>
onoremap aN- :<c-u>normal! F-vF-<cr>

onoremap in, :<c-u>normal! f,lvt,<cr>
onoremap an, :<c-u>normal! f,vf,<cr>
onoremap iN, :<c-u>normal! F,hvT,<cr>
onoremap aN, :<c-u>normal! F,vF,<cr>

onoremap in* :<c-u>normal! f*lvt*<cr>
onoremap an* :<c-u>normal! f*vf*<cr>
onoremap iN* :<c-u>normal! F*hvT*<cr>
onoremap aN* :<c-u>normal! F*vF*<cr>

onoremap in# :<c-u>normal! f#lvt#<cr>
onoremap an# :<c-u>normal! f#vf#<cr>
onoremap iN# :<c-u>normal! F#hvT#<cr>
onoremap aN# :<c-u>normal! F#vF#<cr>

onoremap in$ :<c-u>normal! f$lvt$<cr>
onoremap an$ :<c-u>normal! f$vf$<cr>
onoremap iN$ :<c-u>normal! F$hvT$<cr>
onoremap aN$ :<c-u>normal! F$vF$<cr>

""    Headers
"""        Basic headers

augroup Headers
  au!
  au BufNewFile *.sh 0r $HOME/.vim/skel/bash_header
  au BufNewFile *.html 0r $HOME/.vim/skel/html_header
augroup end

"""        Auto protect c header

if !exists("autocommands_loaded")
  let autocommands_loaded = 1
  au BufNewFile *.h call InsertCHHeader()
endif

function! InsertCHHeader() abort
  let path_to_skeletons = "$HOME/dotfiles/vim/skel/ch_header"
  " Save cpoptions
  let cpoptions = &cpoptions
  " Remove the 'a' option - prevents the name of the
  " alternate file being overwritten with a :read command
  exe "set cpoptions=" . substitute(cpoptions, "a", "", "g")
  exe "read " . path_to_skeletons
  " Restore cpoptions
  exe "set cpoptions=" . cpoptions
  1, 1 delete _

  let fname = expand("%:t")
  let fname = toupper(fname)
  let fname = substitute(fname, "\\.", "_", "g")
  %s/HEADERNAME/\=fname/g
endfunction

"""        42Header

" let s:asciiart = [
"       \"               /          ",
"       \"     .::    .:/ .      .::",
"       \"  +:+:+   +:    +:  +:+:+ ",
"       \"   +:+   +:    +:    +:+  ",
"       \"  #+#   #+    #+    #+#   ",
"       \" #+#   ##    ##    #+#    ",
"       \"###    #+. /#+    ###.fr  ",
"       \"          /               ",
"       \"         /                ",
"       \"           LE - /         "
"       \]

" let s:asciiart = [
"       \":.:      .: .:  .:      .:",
"       \" :+:   :+: +:+ +:+:   :+:+",
"       \"  +:+ +:+  +:+ +:+:+ +:+:+",
"       \"    #+#    #+# #+# #+# #+#",
"       \"     +     #+# #+#  +  #+#",
"       \""
"       \]

" :.:     :.: :.: :.:     :.:
"  :+:   :+:  +:+ +:+:   :+:+
"   +:+ +:+   +:+ +:+:+ +:+:+
"    +#+#+    #+# #+# #+# #+#
"     #+#     #+# #+# #+# #+#
"      +      #+# #+#  +  #+#

let s:asciiart = [
      \"        :::      ::::::::",
      \"      :+:      :+:    :+:",
      \"    +:+ +:+         +:+  ",
      \"  +#+  +:+       +#+     ",
      \"+#+#+#+#+#+   +#+        ",
      \"     #+#    #+#          ",
      \"    ###   ########lyon.fr"
      \]

let s:start    = '/*'
let s:end    = '*/'
let s:fill    = '*'
let s:length  = 80
let s:margin  = 5

let s:types    = {
      \'\.c$\|\.h$\|\.cc$\|\.hh$\|\.cpp$\|\.hpp$\|\.php':
      \['/*', '*/', '*'],
      \'\.htm$\|\.html$\|\.xml$':
      \['<!--', '-->', '*'],
      \'\.js$':
      \['//', '//', '*'],
      \'\.tex$':
      \['%', '%', '*'],
      \'\.ml$\|\.mli$\|\.mll$\|\.mly$':
      \['(*', '*)', '*'],
      \'\.vim$\|\vimrc$':
      \['"', '"', '*'],
      \'\.el$\|\emacs$':
      \[';', ';', '*'],
      \'\.f90$\|\.f95$\|\.f03$\|\.f$\|\.for$':
      \['!', '!', '/']
      \}

function! s:filetype() abort
  let l:f = s:filename()
  let s:start  = '#'
  let s:end  = '#'
  let s:fill  = '*'
  for type in keys(s:types)
    if l:f =~ type
      let s:start  = s:types[type][0]
      let s:end  = s:types[type][1]
      let s:fill  = s:types[type][2]
    endif
  endfor
endfunction

function! s:ascii(n) abort
  return s:asciiart[a:n - 3]
endfunction

function! s:textline(left, right)
  let l:left = strpart(a:left, 0, s:length - s:margin * 3 - strlen(a:right) + 1)
  return s:start . repeat(' ', s:margin - strlen(s:start)) . l:left . repeat(' ', s:length - s:margin * 2 - strlen(l:left) - strlen(a:right)) . a:right . repeat(' ', s:margin - strlen(s:end)) . s:end
endfunction

function! s:line(n) abort
  if a:n == 1 || a:n == 11 " top and bottom line
    return s:start . ' ' . repeat(s:fill, s:length - strlen(s:start) - strlen(s:end) - 2) . ' ' . s:end
  elseif a:n == 2 || a:n == 10 " blank line
    return s:textline('', '')
  elseif a:n == 2 || a:n == 3 || a:n == 5 || a:n == 7 || a:n == 10 || a:n == 11 " empty with ascii
    return s:textline('', s:ascii(a:n))
  elseif a:n == 4 " filename
    return s:textline(s:filename(), s:ascii(a:n))
  elseif a:n == 6 " author
    return s:textline("By: " . s:user() . " <" . s:mail() . ">", s:ascii(a:n))
  elseif a:n == 8 " created
    return s:textline("Created: " . s:date() . " by " . s:user(), s:ascii(a:n))
  elseif a:n == 9 " updated
    return s:textline("Updated: " . s:date() . " by " . s:user(), s:ascii(a:n))
  endif
endfunction

function! s:user() abort
  let l:user = $USER
  if strlen(l:user) == 0
    let l:user = "trx"
  endif
  return l:user
endfunction

function! s:mail() abort
  let l:mail = $MAIL
  if strlen(l:mail) == 0
    let l:mail = "tristan.kapous@protonmail.com"
  endif
  return l:mail
endfunction

function! s:filename() abort
  let l:filename = expand("%:t")
  if strlen(l:filename) == 0
    let l:filename = "< new >"
  endif
  return l:filename
endfunction

function! s:date() abort
  return strftime("%Y/%m/%d %H:%M:%S")
endfunction

function! s:insert() abort
  let l:line = 11
  " empty line after header
  call append(0, "")
  " loop over lines
  while l:line > 0
    call append(0, s:line(l:line))
    let l:line = l:line - 1
  endwhile
endfunction

function! s:update() abort
  call s:filetype()
  if getline(9) =~ s:start . repeat(' ', s:margin - strlen(s:start)) . "Updated: "
    if &mod
      call setline(9, s:line(9))
    endif
    call setline(4, s:line(4))
    return 0
  endif
  return 1
endfunction

function! Header101() abort
  if s:update()
    call s:insert()
  endif
endfunction

" Bind command and shortcut
command! Header101 call Header101()
" nnoremap <leader>h1 :Header101<cr>
nnoremap <silent> <leader>h1 :Header101<cr>
" au BufWritePre * call s:update ()

"""        Signature

function! MailSignature() abort
  let firstname = "Tristan"
  let surname = "Kapous"
  let email = "<tris@tristankapous.com>"
  let prefix = "--"
  let signature_undated = prefix . " " . firstname . " " . surname . " " . email
  if getline('$') =~ '^.*'.signature_undated
    :$d
  endif
  let signature = signature_undated . " " . strftime('%a, %d %b %Y %H:%M:%S')
  call append('$', signature)
endfunction

function! DebianLogSignature() abort
  let firstname = "Tristan"
  let surname = "Kapous"
  let email = "<tris@tristankapous.com>"
  let prefix = "--"

  let signature_undated = prefix . " " . firstname . " " . surname . " " . email
  let signature = signature_undated . " " . strftime('%a, %d %b %Y %H:%M:%S %z')
  if getline('.') =~ '^.*'.signature_undated
    call setline('.', signature)
  else
    call append('.', signature)
  endif
endfunction

" augroup SignOnSave
"   au!
"   au BufWritePre * call SignatureTime() | normal! <c-o><c-o>
" augroup end

""    Dotfiles settings
"""        Filetype

augroup DotfilesSettings
  au!
  au BufEnter,BufWritePost {,.}bash_aliases,{,.}bashrc,{,.}inputrc,{,.}bash_profile
        \ setlocal filetype=sh colorcolumn=0
augroup end

"""        Vimrc mappings

augroup VimrcMaps
  au!
  au FileType vim silent nnoremap <buffer> zM :setlocal foldlevel=0<cr>zm100<c-y>
  au FileType vim inoremap <buffer> ,""<space> ""<space><space><space><space>
  au FileType vim inoremap <buffer> ,"""<space> """<space><space><space><space><space><space><space><space>
  au FileType vim inoremap <buffer> ,''<space> ""<space><space><space><space>
  au FileType vim inoremap <buffer> ,'''<space> """<space><space><space><space><space><space><space><space>
augroup end

"""        Vimrc folding

function! VimFold() abort
  let line = getline(v:foldstart)

  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 4
  if windowwidth > 79
    let windowwidth = 79
  endif
  let foldedlinecount = v:foldend - v:foldstart
  " expand tabs into spaces
  let onetab = strpart('          ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')
  let longbreak=" "
  let line = strpart(line, 0, windowwidth - 2 - len(foldedlinecount))
  if len(line) > windowwidth - 15
    let line=line[0:windowwidth - 15]
    let longbreak="¬"
  endif
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
  return line . longbreak . repeat(" ", fillcharcount%2 + len(foldedlinecount) - 1) . '' . repeat(" .",fillcharcount/2 - 3) . repeat(" ", 5 - len(foldedlinecount)) . foldedlinecount . '    '
endfunction

"""        Vimrc modeline

" vim:expandtab
" vim:tw=0:ts=2:sts=2:shiftwidth=2
" vim:foldmethod=expr:foldtext=VimFold()
" vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-1)\:'='
