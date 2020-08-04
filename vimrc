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
set signcolumn=yes
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
