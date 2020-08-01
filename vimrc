" **************************************************************************** "
"                                                                              "
"                                                         :::      ::::::::    "
"    vimrc                                              :+:      :+:    :+:    "
"                                                     +:+ +:+         +:+      "
"    By: tris <tris@tristankapous.com>              +#+  +:+       +#+         "
"                                                 +#+#+#+#+#+   +#+            "
"    Created: 2016/04/14 18:58:30 by tris              #+#    #+#              "
"    Updated: 2020/07/27 06:01:36 by tris             ###   ########lyon.fr    "
"                                                                              "
" **************************************************************************** "

""    Settings
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
set tags=tags,.git/tags


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
set titleold=

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
" set suffixesadd=.tex,.latex,.java,.c,.h,.js    " match file w/ ext
set formatoptions+=j    " join comments smartly
set formatoptions-=cro  " no auto comment line

" augroup NoAutoComment
"   au!
"   au FileType *
"         \ setlocal formatoptions+=j    " join comments smartly
"         \ setlocal formatoptions-=cro  " no auto comment line
" augroup end

" Main window
set display+=lastline           " show lastline even if too long
set number                      " show number column
" set wrap                        " no horizontal scroll
set breakindent                 " with indent
set showbreak=¬                 " ... showing a character
set signcolumn="always"
set nowrap

" augroup ForceWrap
"   au!
"   au BufEnter * setlocal nowrap
" augroup END

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

" Diff
set diffopt+=vertical " vertical split for diff

" False cursorline to have CursorLineNr working
set cursorline

" Tabline
set tabpagemax=30

""    File automation
"""        Save and load

function! FileBottomWindow() abort
  if line('w$') == line('$')
    let save_scroll = &scrolloff
    let &scrolloff = 0
    normal! zb
    let scrolloff = save_scroll
  endif
endfunction

augroup FileBottomWindow
  au!
  au BufEnter * call FileBottomWindow()
augroup END

" Save when focus lost, load when focus gained
augroup AutoSaveAndLoadWithFocus
  au!
  au FocusGained,BufEnter * :silent! !
  au FocusLost,WinLeave * :silent! w
augroup end

" Autocommit
" autocmd BufWritePost * let message = input('Message? ', 'Auto-commit: saved ' . expand('%')) | execute ':silent ! if git rev-parse --git-dir > /dev/null 2>&1 ; then git add % ; git commit -m ' . shellescape(message, 1) . '; fi > /dev/null 2>&1'

"""        Last cursor position

" Open file where it was last closed
augroup ReOpenFileWhereLeft
  au!
  au VimEnter,BufWinEnter *
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

"""        Filetype refresh

"  refresh filetype upon writing if no filetype already set
augroup FileTypeRefresh
  au!
  au BufWrite * if &ft ==# '' | filetype detect | endif
augroup end

"""        Large Files

" large file = 10MB
let g:LargeFile = 1024 * 1024 * 10
augroup LargeFilesFast
  au!
  au BufReadPre *
        \ let f=expand("<afile>")
        \ | if getfsize(f) > g:LargeFile || &filetype == 'help'
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
  au VimEnter * ++nested call AutoProjectLoad('0')
augroup end

nnoremap <leader>ej :e .git/vim/project_files<cr>

""    Plugins settings
"""        Termdebug

" let g:termdebug_wide = 163
let g:termdebug_wide = 40

"""        Vim-run
let g:vim_run_command_map = {
      \'javascript': 'node',
      \'php': 'php',
      \'python': 'python',
      \'markdown': 'markdown',
      \}

"""        Iris

let g:iris_name  = "Tristan Kapous"
let g:iris_mail = "tris@tristankapous.com"

" IMAP (required)
let g:iris_imap_host  = "ssl0.ovh.net"
" let g:iris_imap_host = "imaps://tris@tristankapous.com@ssl0.ovh.net"
let g:iris_imap_port  = 993
" let g:iris_imap_login = "Your IMAP login" "Default to g:iris_mail

" SMTP (req(uir)ed)
" let g:iris_smtp_host  = "your.smtp.host" "Default to g:iris_imap_host
" let g:iris_stmp_host = "smtps://tris@tristankapous.com@ssl0.ovh.net"
let g:iris_smtp_port  = 465
" let g:iris_smtp_login = "Your IMAP login" "Default to g:iris_mail

" let g:iris_imap_passwd_filepath = "iris.imap.gpg"
" let g:iris_smtp_passwd_filepath = "iris.smtp.gpg"

""    General Mappings
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

"""        Toggles

" Toggle / close / open Undotree
let g:undotree_SetFocusWhenToggle = 1
nnoremap you :UndotreeToggle<cr>
nnoremap [ou :UndotreeShow<cr>
nnoremap ]ou :UndotreeHide<cr>
nnoremap yo<c-u> :UndotreeFocus<cr>

" Obsession
nnoremap yoo :call ToggleObsession()<cr>

" Switch dark / light theme[
nnoremap <silent> yob :call DarkLightSwitch()<cr>

" Netrw toggle - left
nnoremap <silent> yoe :20Lexplore<cr>

" Move visual selection (=unimpaired + gv)
vnoremap ]e :'<,'>move '>+1 \| normal! gv<CR>
vnoremap [e :'<,'>move '<-2 \| normal! gv<CR>

" Toggle of hlsearch + Anzu
nnoremap <silent> yoh :call anzu#clear_search_status()<cr>:nohlsearch<cr>

" Toggle terminal - bottom
nmap yoT <Plug>(TermPop)

" Toggle terminal - right
nmap yo<c-t> <Plug>(TermToggleV)

" Toggle terminal - right
nmap yot <Plug>(TermToggle)

" Toggle keep cursor in middle of screen
nnoremap <silent> yoz :let &scrolloff=999-&scrolloff<cr>

" Load project files buffers
nnoremap yoj :call AutoProjectLoad('1')<cr>

" Goyo toggle
nnoremap yog :Goyo<cr>

"""        Copy / Paste / Delete

" select last paste
nnoremap gp V`]

" delete without saving to register
nnoremap <leader>d "_d
xnoremap <leader>d "_d
" xnoremap <leader>p "_dP

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
  return system("detex " . expand("%") . " | wc -w | tr -d [[:space:]]") "words"
endfunction

command! -nargs=1 -complete=command Nomove
\   try
\ |     let s:svpos = winsaveview()
\ |     execute <q-mods> <q-args>
\ | finally
\ |     call winrestview(s:svpos)
\ |     unlet s:svpos
\ | endtry

function! CountRealLines()
    let l:count = 0
    Nomove g/^[^$,\"]/let l:count += 1
    return l:count
endfunction

nnoremap <leader>wcc :echo WordCount()<cr>
nnoremap <leader>wcl :echo CountRealLines()<cr>

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
nnoremap <leader>sv mz:source $MYVIMRC<cr>:silent doautocmd BufRead<cr>:nohlsearch<cr>:echo "vimrc sourced"<cr>`zzz
nnoremap <leader>ss mz:source $MYVIMRC<cr>:nohlsearch<cr>:redraw<cr>:doautocmd BufRead<cr>:echo "all fresh"<cr>`zzz

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

"""        Command Line

" cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
cnoremap <c-r><c-5> <C-R>=fnameescape(expand('%:h')).'/'<cr>
nnoremap <leader>vp :find <cr>vim/plugin/


""    Move Mappings
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
" onoremap <leader><space> <c-^>
vnoremap <leader><space> <c-^>

" last buffer in vertical split
nnoremap <c-w><space><space> :vertical split #<cr>
" onoremap <c-w><space><space> :vertical split #<cr>
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
    if c == 'p'
      let c = nr2char(1+char2nr(c))
    endif
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

  exe "set <S-F31>=\eH"
  exe "set <S-F32>=\eJ"
  exe "set <S-F33>=\eK"
  exe "set <S-F34>=\eL"

  inoremap <F31> <left>
  inoremap <F32> <down>
  inoremap <F33> <up>
  inoremap <F34> <right>

  nnoremap <silent> <F31> :wincmd h<cr>
  nnoremap <silent> <F32> :wincmd j<cr>
  nnoremap <silent> <F33> :wincmd k<cr>
  nnoremap <silent> <F34> :wincmd l<cr>

  tnoremap <silent> <F31> <c-\><c-n>:wincmd h<cr>
  tnoremap <silent> <F32> <c-\><c-n>:wincmd j<cr>
  tnoremap <silent> <F33> <c-\><c-n>:wincmd k<cr>
  tnoremap <silent> <F34> <c-\><c-n>:wincmd l<cr>

  cnoremap <F31> <left>
  cnoremap <F32> <down>
  cnoremap <F33> <up>
  cnoremap <F34> <right>

  nnoremap <silent> <S-F31> :exe "resize -1"<cr>
  nnoremap <silent> <S-F32> :exe "vertical resize -1"<CR>
  nnoremap <silent> <S-F33> :exe "vertical resize +1"<CR>
  nnoremap <silent> <S-F34> :exe "resize +1"<cr>

else

  inoremap <M-h> <left>
  inoremap <M-j> <down>
  inoremap <M-k> <up>
  inoremap <M-l> <right>

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

  nnoremap <silent> <M-K> :exe "resize +1"<cr>
  nnoremap <silent> <M-J> :exe "resize -1"<cr>
  nnoremap <silent> <M-L> :exe "vertical resize +1"<CR>
  nnoremap <silent> <M-H> :exe "vertical resize -1"<CR>

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

nnoremap / :call clearmatches()<cr>/
nnoremap <leader>/ :call clearmatches()<cr>/\v
vnoremap <leader>/ :call clearmatches()<cr>/\v

nnoremap <silent> n :call NextPrevSearch('n')<cr>
nnoremap <silent> N :call NextPrevSearch('N')<cr>

"do not move cursor with first match
nnoremap <silent> * :let @/= '\<' . expand('<cword>') . '\>' <bar> set hls <cr>:call HLCurrent()<cr>
nnoremap <silent> g* :let @/=expand('<cword>') <bar> set hls <cr>

" search visual selection
vnoremap * y/\V<C-R>=escape(@",'/\')<CR><CR>

"""        Command Line

cnoremap <c-a> <Home>
cnoremap <c-e> <End>
cnoremap <c-k> <Up>
cnoremap <c-j> <Down>
cnoremap <c-b> <Left>
cnoremap <c-l> <S-Right>
cnoremap <c-g> <S-Left>
cnoremap <c-x> <c-\>estrpart(getcmdline(), 0, getcmdpos() - 1)<cr>
cnoremap <c-o> <s-tab>
cnoremap <c-r><c-l> <c-r>=substitute(getline('.'), '^\s*', '', '')<cr>
cnoreabbrev <expr> qqq getcmdpos() == 4 ? "qall!" : "qqq"

"""        Tags

" show matching tags
nnoremap g<c-]> g]

" jump if only one match
nnoremap g] g<c-]>

"""        Select lines starting with same world

function! SelectFirstWordBlock(all) abort
  let curpos = getpos('.')
  let curline = curpos[1]
  let nextline = curline + 1
  let firstword = split(trim(getline('.')), '\W\+')[0]
  while (a:all == 1 && split(trim(getline(nextline)), '\W\+')[0] =~ firstword)
    let nextline += 1
  endwhile
  while (a:all == 0 && split(trim(getline(nextline)), '\W\+')[0] ==# firstword)
    let nextline += 1
  endwhile
  normal! V
  call cursor(nextline - 1, 0)
endfunction

function! SelectFirstWordBlockVisual() abort
  let curpos = getpos('.')
  let curline = curpos[1]
  let nextline = curline + 1
  let firstword = @*
  while (getline(nextline) =~ firstword)
    let nextline += 1
  endwhile
  " echo nextline
  normal! V
  call cursor(nextline - 1, 0)
endfunction

vnoremap <c-p> :call SelectFirstWordBlockVisual()<cr>
nnoremap <leader>V :silent! call SelectFirstWordBlock('1')<cr>
nnoremap <leader><c-v> :silent! call SelectFirstWordBlock('0')<cr>

"""        Folding

nnoremap zM zMzb
nnoremap <silent> zm :set scrolloff=0<cr>zmzb:let &scrolloff=winheight(win_getid())/10 + 1<cr>
nnoremap <silent> zb :set scrolloff=0<cr>zb:let &scrolloff=winheight(win_getid())/10 + 1<cr>

""    Code Mappings
"""        General

" indent all file easy
nnoremap g<c-g> :Nomove normal gg=G<cr>
nnoremap gG :Nomove normal =ap<cr>

" Toggle location list (awesome)
nnoremap <expr> <leader>cl get(getloclist(0, {'winid':0}), 'winid', 0) ?
      \ ":lclose<cr>" : ":bot lopen<cr><c-w>p"

" Toggle quickfix list (awesome)
nnoremap <expr> <leader>cq get(getqflist({'winid':0}), 'winid', 0) ?
      \ ":cclose<cr>" : ":bot copen<cr><c-w>p"

" trim current line
nnoremap <silent> <leader>xx :s/\s\+$//<cr>:redraw<cr>
"trim file
nnoremap <leader>xX :%s/\s\+$//<cr>:redraw<cr>
nnoremap <leader>XX :%s/\s\+$//<cr>:redraw<cr>

" Make
nnoremap <leader>cm :make<cr><cr>
nnoremap <leader>cr :Shell make re<cr><cr>
nnoremap <leader>ce :Shell make ex<cr><cr>
nnoremap <leader>ct :Shell make ex TESTFF=test/test*<cr><cr>
nnoremap <leader>cT :Shell make ex TESTFF=
nnoremap <leader>c<c-t> :make ex TEST=test/%<cr><cr>

function! LocListPanel(pfx) abort
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
nnoremap <leader>csm :lmake!<cr>:call LocListPanel('l')<cr>

nnoremap <leader>csr :lmake! re<cr>:call LocListPanel('l')<cr>
nnoremap <leader>cse :Shell make ex<cr><cr>
nnoremap <leader>cst :Shell make ex TESTFF=test/test*<cr><cr>
nnoremap <leader>c<c-s><c-t> :VShell make ex TESTFF=test/test*<cr><cr>
nnoremap <leader>c<c-s>t :VShell make ex TESTFF=test/test*<cr><cr>
nnoremap <leader>cs<c-t> :VShell make ex TESTFF=test/test*<cr><cr>
nnoremap <leader>cs<c-t> :VShell make ex TEST=test/%<cr><cr>
nnoremap <leader>csT :Shell make ex TESTFF=

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

if has("nvim")
  inoremap <expr> <c-space> pumvisible() ? coc#_select_confirm() : coc#refresh()
else
  inoremap <expr> <c-@> pumvisible() ? coc#_select_confirm() : coc#refresh()
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
" nnoremap <silent> K :call <SID>show_documentation()<CR>

" function! s:show_documentation() abort
"   if index(['vim','help'], &filetype) >= 0
"     execute 'h '.expand('<cword>')
"   else
"     call CocAction('doHover')
"   endif
" endfunction

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

""    Operators
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

" Bind command and shortcut
command! Header101 call Header101()
" nnoremap <leader>h1 :Header101<cr>
nnoremap <silent> <leader>h1 :Header101<cr>
" au BufWritePre * call s:update ()

""    Dotfiles settings
"""        Filetype

" augroup DotfilesSettings
"   au!
"   au BufEnter,BufWritePost {,.}bash_aliases,{,.}bashrc,{,.}inputrc,{,.}bash_profile
"         \ setlocal filetype=sh colorcolumn=0
" augroup end

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
  return line . longbreak . repeat(" ", fillcharcount%2 + len(foldedlinecount) - 1) . '' .
        \ repeat(" .",fillcharcount/2 - 3) .
        \ repeat(" ", 5 - len(foldedlinecount)) . foldedlinecount . '    '
endfunction

"""        Vimrc modeline

" vim:expandtab
" vim:tw=0:ts=2:sts=2:shiftwidth=2
" vim:foldmethod=expr:foldtext=VimFold()
" vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-1)\:'='
