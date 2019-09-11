" ************************************************************************** "
"                                                                            "
"    vimrc                                                                   "
"                                                |_   _|  _ __  (_)  ___     "
"    By: tris <tristan.kapous@protonmail.com>      | |   | '__| | | / __|    "
"                                                  | |   | |    | | \__ \    "
"    Created: 2019/06/23 05:39:33 by tris          |_|   |_|    |_| |___/    "
"    Updated: 2019/08/06 19:27:58 by tris                                    "
"                                                                            "
" ************************************************************************** "

""  Signature
" """""""""""""""""""""""""""""""""""""""""""""""""""
"  ____ _____ _____  _______     ______ _____		"
" |  _ \_   _/ ____|/ ____\ \   / /  _ \_   _|		"
" | |_) || || |  __| |  __ \ \_/ /| |_) || |		"
" |  _ < | || | |_ | | |_ | \   / |  _ < | |		"
" | |_) || || |__| | |__| |  | |  | |_) || |_		"
" |____/_____\_____|\_____|  |_|  |____/_____|vimrc "
"													"
" """""""""""""""""""""""""""""""""""""""""""""""""""

""  Vimrc settings

set nocompatible " not compatible with vi
filetype plugin on
" set shellcmdflag=-ic
let $BASH_ENV = "$HOME/dotfiles/bash_aliases" " use aliases in vim
let $PAGER=''	" clear pager env var in vim (for vim as pager)

" pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" automatically reload vimrc when modified
" autocmd! BufWritePost $MYVIMRC silent source $MYVIMRC

" source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>:w<cr>:echo "vimrc sourced"<cr>
nnoremap <leader>sy :YcmRestartServer<cr>:echo "YCM fresh"<cr>:w<cr>
nnoremap <leader>ss :source $MYVIMRC<cr>:nohlsearch<cr>:YcmRestartServer<cr>:redraw<cr>:w<cr>:echo "all fresh"<cr>

" edit dotfiles
nnoremap <leader>ev :e $DOT/vimrc<cr>
nnoremap <leader>e<c-v> :vertical split $DOT/vimrc<cr>
nnoremap <leader>eb :e $DOT/bashrc<cr>
nnoremap <leader>e<c-b> :vertical split $DOT/bashrc<cr>
nnoremap <leader>ea :e $DOT/bash_aliases<cr>
nnoremap <leader>e<c-a> :vertical split $DOT/bash_aliases<cr>
nnoremap <leader>ei :e $DOT/inputrc<cr>
nnoremap <leader>e<c-i> :vertical split $DOT/inputrc<cr>
nnoremap <leader>ep $DOT/bash_profile<cr>
nnoremap <leader>e<c-p> :vertical split $DOT/bash_profile<cr>
nnoremap <leader>ec1 :e $DOT/vim/colors/base16-onedark.vim<cr>
nnoremap <leader>ec2 :e $DOT/vim/colors/base16-one-light.vim<cr>
set notimeout
set ttimeout
set ttimeoutlen=10


""  General

" let mapleader = " "
" let leader = " "
map <space> <leader>
set iskeyword+=,

nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

inoremap jk <esc>
cnoremap jk <esc>
" nnoremap gI `.
nnoremap gI gi<esc>
nnoremap Q <nul> "no more default ex mode
" inoremap <c-w><c-e> <esc><silent>:write<cr>
" nnoremap <c-w><c-e> <silent>:write<cr>
nnoremap <c-s> :w<cr>
inoremap <c-s> <c-o>:stopinsert<cr>:w<cr><esc>
cnoremap W! %!sudo tee > /dev/null %

set history=10000 " default 20

" backspace behave in a sane manner
set backspace=indent,eol,start

" faster redrawing
set ttyfast

" Backup files dir
set backupskip=/tmp/*,/private/tmp/*"		" vim can edit crontab
set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/swap//
set undodir=$HOME/.vim/undo//

" Shortmess : 'hit enter' prompt custzomization
set shortmess+=A				" No error message when swap exists, just edit
set shortmess+=f				" Abbreviation for file count
set shortmess+=i				" Abbreviation for line without end
set shortmess+=l				" Abbreviation for line and word count
set shortmess+=m				" Abbreviation for modified
set shortmess+=n				" Abbreviation for new file
set shortmess+=r				" Abbreviation for read only
set shortmess+=w				" Abbreviation for writter
set shortmess+=x				" Abbreviation for dos and mac format
set shortmess+=W				" No message when writing
" set cmdheight=2

set hidden
set suffixesadd=.tex,.latex,.java,.c,.h,.js

" set noswapfile

" gnome adaptive cursor shape
" if has("autocmd")
"   au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
"   au InsertEnter,InsertChange *
"     \ if v:insertmode == 'i' |
"     \   silent execute '!echo -ne "\e[6 q"' | redraw! |
"     \ elseif v:insertmode == 'r' |
"     \   silent execute '!echo -ne "\e[4 q"' | redraw! |
"     \ endif
"   au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
" endif


""  User Interface

set ruler
set mouse=a
set visualbell
set noerrorbells
set t_vb=
set wildmenu
set showmode
set showcmd

" tabulation control
set noexpandtab				" tabs ftw
set smarttab				" tab respects 'tabstop' 'shiftwidth' 'softtabstop'
set tabstop=4				" the visible width of tabs
set softtabstop=4			" tabs 4 characters wide
set shiftwidth=4			" indents 4 characters wide
set autoindent				" automatically set indent of new line
set smartindent				" ... in a sane way
set shiftround				" round indent to a multiple of 'shiftwidth'
filetype indent on

set splitbelow				" default split below
set splitright				" default split right
" set equalalways			" always equalize windows
" set list					" show invisible characters
" set listchars=tab:>\ ,trail:·	" but only show tabs and trailing whitespace

set number					" show number column
set relativenumber			" relative to current line

" set number relativenumber
" augroup NumToggle
" 	autocmd!
" 	autocmd VimEnter,WinEnter,BufWinEnter * set number relativenumber
" 	autocmd WinLeave * set nonumber norelativenumber
" augroup END

set virtualedit=block		" visual selection broken free

set whichwrap+=<,>,h,l,[,]	" free cursor betweem lines
set wrap					" no horizontal scroll
" set linebreak				" break lines
set breakindent				" with indent
set showbreak=\ \ ¬			" ... showing a character

set sidescrolloff=3			" horizontal cursor max value
let &scrolloff=winheight(win_getid())/10 " minumum lines before/after cursor

" toggle always in middle with zz
nnoremap <silent> <leader>zz :let &scrolloff=999-&scrolloff<cr>

" status line
set laststatus=2			" show the satus line all the time
" show buffer number
set statusline=%02n:%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

" open file under cursor in vertical split
nnoremap g<c-f> :vertical wincmd f<cr>


""  Look / Theme

syntax on

if (has("termguicolors"))
  set termguicolors
endif

" open vim with different color based on time of day
let hour = strftime("%H")

" switch between light and dark theme (UI + ligtline)
function! DarkLightSwitch()
	if g:DarkLightSwitch == 'light'
		set background=light
		source $HOME/.vim/colors/base16-onedark.vim
		let g:lightline = { 'colorscheme': 'wombat' }
		let g:DarkLightSwitch = 'dark'
	else
		set background=dark
		source $HOME/.vim/colors/base16-one-light.vim
		let g:lightline = { 'colorscheme': 'wombat_light' }
		let g:DarkLightSwitch = 'light'
	endif
	if exists("g:DarkLightOn")
		call lightline#enable()
	endif
	let g:DarkLightOn = 'on'
endfunction

if ! exists ("g:DarkLightSwitch")
	let hour = strftime("%H")
	if 9 <= hour && hour < 19
		let g:DarkLightSwitch = 'dark'
	else
		let g:DarkLightSwitch = 'light'
	endif
	call DarkLightSwitch()
endif

nnoremap <silent> <leader>sc :call DarkLightSwitch()<cr>

" source colors
nnoremap <silent> <leader>s1 :source $HOME/.vim/colors/base16-onedark.vim<cr>
nnoremap <silent> <leader>s2 :source $HOME/.vim/colors/base16-one-light.vim<cr>

" code
set encoding=utf8
let base16colorspace=256  " access colors present in 256 colorspace"
set t_Co=256 " explicitly tell vim that the terminal supports 256 colors"


""  Highlights / Match

" highlight overlength ctermbg=203 ctermfg=white guibg=#592928
" match overlength /\%81v.\+/

" show traling whitespaces

match TrailWhite /\s\+$/
autocmd BufWinEnter * match TrailWhite /\s\+$/
autocmd InsertEnter * match TrailWhite /\s\+\%#\@<!$/
autocmd InsertLeave * match TrailWhite /\s\+$/
autocmd BufWinLeave * call clearmatches()

" focus current window : cursorline and relative numbers
augroup WinFocus
  autocmd!
  autocmd VimEnter,WinEnter,BufNew,WinNew * setlocal cursorline "relativenumber number
  autocmd WinLeave * setlocal nocursorline "norelativenumber number
augroup end

" color column 81 for code
if exists('+colorcolumn')
 	autocmd Filetype c,cpp,css,java,python,ruby,bash,sh set colorcolumn=81
endif

set mat=2 " how many tenths of a second to blink

""  Window behaviour

" open buffer with partial search
nnoremap <leader>b :buffer<space>
nnoremap <leader>B :sbuffer<space>
nnoremap <leader><c-b> :vertical sbuffer<space>
" nnoremap <leader>T :vertical sbuffer !/bin/bash<cr>

"go to next / previous buffer
nnoremap <leader>] :bn<cr>
nnoremap <leader>[ :bp<cr>

let g:term_buf = 0
let g:term_win = 0

function! Term_toggle(height)
	if win_gotoid(g:term_win)
		let g:term_win = 0
		hide
	else
		try
			exec "buffer " . g:term_buf
		catch
			vertical terminal
			"             let g:term_buf = bufnr("")
		endtry
		startinsert!
		let g:term_win = win_getid()
	endif
endfunction

nnoremap <leader>T :call Term_toggle(10)<cr>
tnoremap <c-t> <c-\><c-n>:call Term_toggle(10)<cr>

" move between windows with ctrl
" nnoremap <c-h> :wincmd h<cr>
" nnoremap <c-j> :wincmd j<cr>
" nnoremap <c-k> :wincmd k<cr>
" nnoremap <c-l> :wincmd l<cr>
" imap <c-w> <c-o><c-w>

" Note: does not work anymore?
" resize windows quicker
" nnoremap <c-w><c-.> :vertical resize +10<cr>
" nnoremap <c-w><c-,> :vertical resize -10<cr>
" nnoremap <c-w><c-=> :resize +10<cr>
" nnoremap <c-w><c--> :resize -10<cr>

" new file in vertical split instead of horizontal
nnoremap <c-w><c-n> :vertical new<cr>
nnoremap <c-w>n :vertical new<cr>
nnoremap <c-w><c-f> :vertical wincmd f<cr>


""  Folding

set foldmethod=syntax " fold based on indent
set foldnestmax=10 " deepest fold is 10 levels
set nofoldenable " don't fold by default
set foldlevel=1

" automatily save and restore files views (folding state and more)
autocmd BufWinLeave * if expand("%") != "" && &filetype != 'help' && &filetype != 'man' | mkview | endif
autocmd BufWinEnter * if expand("%") != "" && &filetype != 'help' && &filetype != 'man' | loadview | endif

" inoremap <leader><space> <c-o>za
nnoremap <leader><space> za
onoremap <leader><space> <c-c>za
vnoremap <leader><space> zf

" recursively open even partial folds
nnoremap zo zczO

""  File automation

set autoread "not working until cmd like :e
" detect when a file is changed
if ! exists("g:CheckUpdateStarted")
    let g:CheckUpdateStarted=1
    call timer_start(1,'CheckUpdate')
endif
function! CheckUpdate(timer)
    silent! checktime
    call timer_start(1000,'CheckUpdate')
endfunction

" autosave file upon modification
" autocmd TextChanged,TextChangedI <buffer> silent write

" open file where it was closed
autocmd BufReadPost *
			\ if line("'\"") > 0 && line("'\"") <= line("$") |
			\   exe "normal! g`\"" |
			\ endif

" filetype recognition
au FileType c setlocal ofu=ccomplete#CompleteCpp
au FileType css setlocal ofu=csscomplete#CompleteCSS
au FileType html,xhtml setlocal ofu=htmlcomplete#CompleteTags
au FileType php setlocal ofu=phpcomplete#CompletePHP
au FileType ruby,eruby setlocal ofu=rubycomplete#Complete
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" refresh filetype upon writing
autocmd BufWritePost * filetype detect

" auto chose tag from .git folder
autocmd BufEnter * set tags=.git/tags

" auto winwidth for code
" autocmd Filetype html,c,cpp,java setlocal winwidth=86

" autoreload tags file on save
" au BufWritePost *.c,*.cpp,*.h silent! !ctags -R --langmap=c:.c.h &
" au BufWritePost *.cpp silent! !ctags -R &
" set tags=tags;./git/
" set tags=./tags;

autocmd FileType man,help setlocal noswapfile nobackup nobuflisted nolinebreak cursorline norelativenumber nonumber colorcolumn=0 signcolumn=no
autocmd FileType help wincmd H | 79 wincmd|
autocmd FileType man wincmd H
autocmd BufEnter *.txt if (&filetype == 'help') | 79 wincmd| | endif

augroup HelpManMaps
	autocmd! HelpManMaps
	autocmd Filetype help,man nnoremap <buffer> <silent> q :bw<cr>
augroup end

" Open man page in vim split, defaults to K
runtime! ftplugin/man.vim
set keywordprg=:Man


""  Searching

" set path+=**			" recursive path from current path
" set incsearch
set wildchar=<tab>
set wildmode=full
" set wildmode=longest:full:list,full


set ignorecase			" case insensitive searching
set smartcase			" case-sensitive if expresson contains a capital letter
set hlsearch			" highlight all searches
set incsearch			" set incremental search, like modern browsers
set nolazyredraw		" don't redraw while executing macros

set switchbuf=useopen	" open buffers in their window if exist (:sb 'file')

" ignore some files from wildcard expansion
" set wildignore+=**/.git/**,**/__pycache__/**,**/venv/**,**/node_modules/**,**/dist/**,**/build/**,*.o,*.pyc,*.swp
set wildignore+=**/__pycache__/**,**/venv/**,**/node_modules/**,**/dist/**,**/build/**,*.o,*.pyc,*.swp

set magic " Set magic on, for regex

" keep cursor in middle of screen when searching / folding
" nnoremap n nzz
" nnoremap N Nzz
" nnoremap * *zz
" nnoremap # #zz
" nnoremap g* g*zz
" nnoremap g# g#zz
nnoremap zM zMzz
" " nnoremap za zazz
" nnoremap zA zAzz
" nnoremap <leader>za zMzvzz


" use unix regex in searches
" nnoremap / /\v
" vnoremap / /\v

"do not move cursor with match
nnoremap <silent> * :let @/= '\<' . expand('<cword>') . '\>' <bar> set hls <cr>
" vnoremap <silent> * :let @/= '\<' . expand('<cword>') . '\>' <bar> set hls <cr>
nnoremap <silent> g* :let @/=expand('<cword>') <bar> set hls <cr>

"Clear search highlight pressing Enter
nnoremap <silent> - :nohlsearch<cr>

" For local sed replace
nnoremap gr :s/<c-r>///g<left><left>
vnoremap gr :s/<c-r>///g<left><left>
nnoremap gR :%s/<c-r>///g<left><left>

" search visual selection
function! s:VSetSearch()
	let temp = @@
	norm! gvy
	let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
	let @@ = temp
endfunction

vnoremap * :<c-u>cal <SID>VSetSearch()<cr>//<cr><c-o>
vnoremap # :<c-u>cal <SID>VSetSearch()<cr>??<cr><c-o>


""  Autocompletion

set completeopt=longest,menuone
" set completeopt=menuone


" inoremap <c-x>f <c-x><c-f>
" inoremap <c-x>] <c-x><c-]>
" inoremap <c-x>l <c-x><c-l>


""  Plugins settings
""" Fugitive

nnoremap <silent> <leader>gg :vertical Gstatus<cr>
set diffopt+=vertical " vertical split for diff
autocmd FileType gitcommit start
autocmd FileType fugitive setlocal cursorline norelativenumber nonumber colorcolumn=0

""" YouCompleteMe

" YCM move mappings
nnoremap <silent> <leader>cf :ll<cr>:YcmCompleter FixIt<cr>:w<cr>
nnoremap <silent> <leader>gt :YcmCompleter GoTo<cr>
nnoremap <silent> <leader>gd :YcmCompleter GoToDefinitionElseDeclaration<cr>
nnoremap <silent> <leader>ga :YcmCompleter GoToDeclaration<cr>
nnoremap <silent> <leader>gf :YcmCompleter GoToInclude<cr>

let g:ycm_show_diagnostics_ui = 0 " keep syntastic errors
let g:ycm_key_list_stop_completion = [ '<c-y>', '<Enter>' ] " pick with Enter
let g:ycm_key_list_select_completion = ['<c-j>', '<Down>']	" next
let g:ycm_key_list_previous_completion = ['<c-k>', '<Up>']	" previous
let g:ycm_collect_identifiers_from_tags_files = 1			"use tags
let g:ycm_filetype_blacklist = {
			\ 'tagbar': 1,
			\ 'notes': 1,
			\ 'markdown': 1,
			\ 'netrw': 1,
			\ 'unite': 1,
			\ 'text': 1,
			\ 'vimwiki': 1,
			\ 'pandoc': 1,
			\ 'infolog': 1,
			\ 'mail': 1,
			\ 'qf': 1,
			\ 'fugitive': 1,
			\ 'gitcommit': 1,
			\ 'help': 1,
			\ 'tags': 1
			\}

let g:ycm_filetype_specific_completion_to_disable = {
			\ 'fugitive': 1,
			\ 'gitcommit': 1
			\}

" let g:ycm_disable_for_files_larger_than_kb = 12000	" for fugitive status window

" inoremap <expr> <tab> pumvisible() ? "\<c-v>\<tab>" : "\<tab>"
" inoremap <expr> <c-j> pumvisible() ? "\<c-n>" : "\<tab>"
" inoremap <expr> <c-k> pumvisible() ? "\<c-p>" : "\<S-tab>"

""" Syntastic
" let g:syntastic_c_config_file = ['$HOME/dotfiles/.vim/c_errors_file']
let g:syntastic_c_include_dirs = ['inc']
let g:syntastic_c_compiler_options = "-Wall -Wextra"
let g:ycm_global_ycm_extra_conf = '~/dotfiles/ycm_extra_conf.py'

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" set statusline+=%H*

let g:syntastic_c_remove_include_errors = 1
let g:syntastic_enable_c_checker = 1
let g:syntastic_c_check_header = 1
let g:syntastic_c_checkers = ['make', 'gcc', 'clangcheck']
let g:syntastic_tex_checkers = ['lacheck']
let g:ycm_use_clangd = 1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

""" Lightline
set noshowmode " do not show mode in status line
" Show full path of filename

" let g:lightline.colorscheme = 'wombat'

let g:lightline.mode_map = {
			\	'n': ' N ',
			\	'i': ' I ',
			\	'R': ' R ',
			\	'v': ' V ',
			\	'V': 'V-L',
			\	"\<c-v>": 'V-B',
			\	'c': ' C ',
			\	's': ' S ',
			\	'S': 'S-L',
			\	"\<c-s>": 'S-B',
			\	't': ' T ' }

let g:lightline.active = {
			\	'left': [ [ 'mode', 'paste' ],
			\			[ 'readonly', 'gitbranch' ],
			\			[ 'relativepath', 'modified' ] ],
		    \	'right': [ [ 'lineinfo' ],
			\			[ 'percent' ],
		    \			[ 'filetype' ] ] }

let g:lightline.inactive = {
			\	'left': [ [ 'readonly', 'gitbranch' ],
			\			[ 'relativepath', 'modified' ] ],
		    \	'right': [ [ 'lineinfo' ],
			\			[ 'percent' ],
		    \			[ 'filetype' ] ] }

" git branch from fugitive
let g:lightline.component_function = {
			\	'format': 'LightlineFileformat',
			\	'modified': 'LightlineModified',
			\	'fugitive': 'LightlineFugitive',
			\	'readonly': 'LightlineReadonly',
			\	'gitbranch': 'fugitive#head',
			\	'filename': 'FilenameForLightline' }

" let g:lightline.separator = { 'left': '', 'right': '' }
" let g:lightline.subseparator = { 'left': '', 'right': '' }
let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '|' }

function! LightlineModified()
	return &ft =~ 'help\|vimfiler' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
	return &ft !~? 'help\|vimfiler' && &readonly ? 'RO' : ''
endfunction

function! LightlineFilename()
	return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
				\ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
				\  &ft == 'unite' ? unite#get_status_string() :
				\  &ft == 'vimshell' ? vimshell#get_status_string() :
				\ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
				\ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFileformat()
	return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFugitive()
	if exists('*fugitive#head')
		let branch = fugitive#head()
		return branch !=# '' ? ''.branch : ''
	endif
	return ''
endfunction

""" Gitgutter
if exists('&signcolumn')  " Vim 7.4.2201
	set signcolumn=yes
else
	let g:gitgutter_sign_column_always = 1
endif

""" Man
" let g:ft_man_open_mode = 'vert'

set updatetime=20 " time before writing swap, faster gitgutter
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk

""" FZF
" let g:fzf_layout = { 'window': 'below 10split enew' }
" call fzf#run({'options': '--reverse'})
nnoremap <leader>F :FZF /<cr>			" from root
nnoremap <leader>f :FZF $HOME<cr>		" from HOME
nnoremap <leader><c-f> :FZF .<cr>		" from here
" nnoremap <leader>f :FZF<c-r>=fnamemodify(getcwd(), ':p')<cr><cr>
let g:fzf_history_dir = '~/.local/share/fzf-history'

let g:fzf_layout = { 'down' : '10 reverse' }
let g:fzf_colors =
			\ { 'fg':      ['fg', 'Normal'],
			\ 'bg':      ['bg', 'Normal'],
			\ 'hl':      ['fg', 'Comment'],
			\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
			\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
			\ 'hl+':     ['fg', 'Statement'],
			\ 'info':    ['fg', 'PreProc'],
			\ 'border':  ['fg', 'Ignore'],
			\ 'prompt':  ['fg', 'Conditional'],
			\ 'pointer': ['fg', 'Exception'],
			\ 'marker':  ['fg', 'Keyword'],
			\ 'spinner': ['fg', 'Label'],
			\ 'header':  ['fg', 'Comment'] }

""" Root
let g:root#auto = 1
let g:root#echo = 0


""" Searchhi
let g:searchhi_clear_all_autocmds = 'InsertEnter'
let g:searchhi_update_all_autocmds = 'InsertLeave'
let g:searchhi_open_folds = 0


""" Latex Live Preview

" autocmd FileType tex,plaintex let g:tex_fold_enabled=1
autocmd Filetype tex setlocal updatetime=1000
" let g:livepreview_previewer = 'zathura'
" let g:livepreview_cursorhold_recompile = 0
" let g:livepreview_engine = 'your_engine' . ' [options]'

""  Netrw

" Toggle Vexplore with <leader>t
function! ToggleVExplorer()
	if exists("t:expl_buf_num")
		let expl_win_num = bufwinnr(t:expl_buf_num)
		let cur_win_num = winnr()
		if expl_win_num != -1
			while expl_win_num != cur_win_num
				exec "wincmd w"
				let cur_win_num = winnr()
			endwhile
			close
		endif
		unlet t:expl_buf_num
	else
		silent Lexplore
		let t:expl_buf_num = bufnr("%")
	endif
endfunction
nnoremap <silent> <leader>t :call ToggleVExplorer()<cr>

" Netrw customization
let g:netrw_keepdir= 0
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 2
let g:netrw_altv = 1
let g:netrw_winsize = -25
let g:netrw_sort_sequence = '[\/]$,*'					" sort folders on top
autocmd FileType netrw nmap <c-a> <cr>:wincmd W<cr>

" open netrw if vim starts without file
let g:netrw_startup = 0
let g:netrw_startup_no_file = 1
augroup NetrwStartup
	autocmd!
	autocmd VimEnter * if g:netrw_startup_no_file == '1' && expand("%") == "" | e . | endif
  autocmd VimEnter * if g:netrw_startup == '1' | e . | endif
augroup end

""  Quickfix

augroup ft_quickfix
	au!
	au Filetype qf setlocal colorcolumn=0 nolist nocursorline tw=0

	" vimscript is a joke
	au Filetype qf nnoremap <buffer> <cr> :execute "normal! \<lt>cr>"<cr>
augroup end

au FileType qf call AdjustWindowHeight(1, 5)
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


" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
"
" Note: Must allow nesting of autocmds to enable any customizations for quickfix
" buffers.
" Note: Normally, :cwindow jumps to the quickfix window if the command opens it
" (but not if it's already open). However, as part of the autocmd, this doesn't
" seem to happen.

" autocmd QuickFixCmdPost [^l]* nested botright copen
" autocmd QuickFixCmdPost    l* nested botright lwindo

nnoremap <leader>ct :Shell make ex<cr><cr>
nnoremap <leader>cT :Shell make ex TESTFF=test/*<cr><cr>
nnoremap <leader>c<c-t> :Shell make ex TESTFF=
nnoremap <leader>cv :Shell make ex TEST=<cr><cr>
nnoremap <leader>cm :Shell make re<cr><cr>
nnoremap <leader>cr :Shell make re<cr>
nnoremap <leader>cc :ll<cr>
nnoremap <leader>cn :lnext<cr>
nnoremap <leader>cp :lprevious<cr>

nnoremap ]<c-q> :cc<cr>
nnoremap [q :cprev<cr>
nnoremap ]q :cnext<cr>
nnoremap [Q :cfirst<cr>
nnoremap ]Q :clast<cr>

nnoremap [<c-w> :ll<cr>
nnoremap [w :lprev<cr>
nnoremap ]w :lnext<cr>
nnoremap [W :lfirst<cr>
nnoremap ]W :llast<cr>

""  Shell output split

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
	echo a:cmdline
	let expanded_cmdline = a:cmdline
	for part in split(a:cmdline, ' ')
		if part[0] =~ '\v[%#<]'
			let expanded_part = fnameescape(expand(part))
			let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
		endif
	endfor
	vert new
	setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
	call setline(1, a:cmdline . '  |  ' . expanded_cmdline)
	call setline(2,substitute(getline(1),'.','-','g'))
	execute '$read !'. expanded_cmdline
" 	setlocal nomodifiable
endfunction

""  42
""" 42Header

let s:asciiart = [
			\"               /          ",
			\"     .::    .:/ .      .::",
			\"  +:+:+   +:    +:  +:+:+ ",
			\"   +:+   +:    +:    +:+  ",
			\"  #+#   #+    #+    #+#   ",
			\" #+#   ##    ##    #+#    ",
			\"###    #+. /#+    ###.fr  ",
			\"          /               ",
			\"         /                ",
			\"           LE - /         "
			\]

" let s:asciiart = [
" 			\":.:      .: .:  .:      .:",
" 			\" :+:   :+: +:+ +:+:   :+:+",
" 			\"  +:+ +:+  +:+ +:+:+ +:+:+",
" 			\"    #+#    #+# #+# #+# #+#",
" 			\"     +     #+# #+#  +  #+#",
" 			\""
" 			\]

" :.:     :.: :.: :.:     :.:
"  :+:   :+:  +:+ +:+:   :+:+
"   +:+ +:+   +:+ +:+:+ +:+:+
"    +#+#+    #+# #+# #+# #+#
"     #+#     #+# #+# #+# #+#
"      +      #+# #+#  +  #+#

" let s:asciiart = [
" 			\"        :::      ::::::::",
" 			\"      :+:      :+:    :+:",
" 			\"    +:+ +:+         +:+  ",
" 			\"  +#+  +:+       +#+     ",
" 			\"+#+#+#+#+#+   +#+        ",
" 			\"     #+#    #+#          ",
" 			\"    ###   ########.fr    "
" 			\]

let s:start		= '/*'
let s:end		= '*/'
let s:fill		= '*'
let s:length	= 80
let s:margin	= 5

let s:types		= {
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

function! s:filetype()
	let l:f = s:filename()
	let s:start	= '#'
	let s:end	= '#'
	let s:fill	= '*'
	for type in keys(s:types)
		if l:f =~ type
			let s:start	= s:types[type][0]
			let s:end	= s:types[type][1]
			let s:fill	= s:types[type][2]
		endif
	endfor
endfunction

function! s:ascii(n)
	return s:asciiart[a:n - 3]
endfunction

function! s:textline(left, right)
	let l:left = strpart(a:left, 0, s:length - s:margin * 3 - strlen(a:right) + 1)
	return s:start . repeat(' ', s:margin - strlen(s:start)) . l:left . repeat(' ', s:length - s:margin * 2 - strlen(l:left) - strlen(a:right)) . a:right . repeat(' ', s:margin - strlen(s:end)) . s:end
endfunction

function! s:line(n)
	if a:n == 1 || a:n == 12 " top and bottom line
		return s:start . ' ' . repeat(s:fill, s:length - strlen(s:start) - strlen(s:end) - 2) . ' ' . s:end
		" 	elseif a:n == 2 || a:n == 10 " blank line
		" 		return s:textline('', '')
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

function! s:user()
	let l:user = $USER
	if strlen(l:user) == 0
		let l:user = "marvin"
	endif
	return l:user
endfunction

function! s:mail()
	let l:mail = $MAIL
	if strlen(l:mail) == 0
		let l:mail = "marvin@student.le-101.fr"
	endif
	return l:mail
endfunction

function! s:filename()
	let l:filename = expand("%:t")
	if strlen(l:filename) == 0
		let l:filename = "< new >"
	endif
	return l:filename
endfunction

function! s:date()
	return strftime("%Y/%m/%d %H:%M:%S")
endfunction

function! s:insert()
	let l:line = 12
	" empty line after header
	call append(0, "")
	" loop over lines
	while l:line > 0
		call append(0, s:line(l:line))
		let l:line = l:line - 1
	endwhile
endfunction

function! s:update()
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

function! Stdheader()
	if s:update()
		call s:insert()
	endif
endfunction

" Bind command and shortcut
command! Header101 call Stdheader()
" nnoremap <leader>h1 :Header101<cr>
nnoremap <silent> <leader>h1 :call Stdheader()<cr>
" autocmd BufWritePre * call s:update ()

""  Mappings

" Word count
nnoremap <leader>w :w !detex \| wc -w<cr>

" <c-z> in insert mode
inoremap <c-z> <c-[><c-z>

" % as <c-g>
nnoremap <c-g> %

" up down on lines as seen
nnoremap <silent> j gj
nnoremap <silent> k gk

" delete without saving to register
nnoremap <leader>d "_d
xnoremap <leader>d "_d
" xnoremap <leader>p "_dP

" rename file
nnoremap <leader>mv :!mv % %:h:p/

" paste with indentation
" nnoremap P mp]P==`p
" nnoremap p mp]p==`p

nnoremap cl c$
nnoremap dl d$
nnoremap yl y$
nnoremap ch c^
nnoremap dh d^
nnoremap yh y^

" Copy/paste text to/from the system clipboard.
set clipboard=unnamed
nnoremap <leader>p mp"+]p==`p
nnoremap <leader>P mp"+]P==`p
nnoremap <leader>y "+y
nnoremap <leader>Y "+y$
" nnoremap <leader>p V !xsel -o
" nnoremap <leader>P 
" nnoremap <leader>y !xsel -b<cr>
" nnoremap <leader>y V !xclip -i<cr>
" nnoremap <leader>Y 


" vnoremap <leader>p mp"*]p==`p
" vnoremap <leader>P mp"*]P==`p
vnoremap <leader>y "*y
" vnoremap <leader>Y "*yy

nnoremap H ^
nnoremap L g_
nnoremap <c-h> B
nnoremap <c-l> W
nnoremap <c-k> {
nnoremap <c-j> }
nnoremap <c-q> <silent>:redraw<cr>

vnoremap H ^
vnoremap L g_
vnoremap <c-h> B
vnoremap <c-l> W
vnoremap <c-k> {
vnoremap <c-j> }

cnoremap <c-a> <Home>
cnoremap <c-e> <End>
cnoremap <c-k> <Up>
cnoremap <c-j> <Down>
cnoremap <c-b> <Left>
cnoremap <c-f> <Right>
cnoremap <c-l> <S-Right>
cnoremap <c-h> <S-Left>
cnoremap <c-x> <Del>
cnoremap <c-o> <s-tab>

" helpers for dealing with other people's code
" nmap \t :set ts=4 sts=4 sw=4 noet<cr>
" nmap \s :set ts=4 sts=4 sw=4 et<cr>


""  Code mappings

augroup Cmaps
	autocmd! Cmaps
	autocmd FileType c inoreabbrev <buffer> ,ma <esc>:Header101<cr>iint<tab><tab>main(int ac, char **av)<cr>{<cr>}<esc>Oreturn(0);<esc>O
	autocmd FileType c inoreabbrev <buffer> ,if if ()<cr>{<cr>}<esc>2k3==f)i
	autocmd FileType c inoreabbrev <buffer> ,wh while ()<cr>{<cr>}<esc>2k3==f)i
	autocmd FileType c inoreabbrev <buffer> ,imin -2147483648
	autocmd FileType c inoreabbrev <buffer> ,imax 2147483647
	autocmd FileType c inoreabbrev <buffer> ,endl ft_putendl("");<left><left><left>

	autocmd FileType c nnoremap <buffer> <leader><c-]> <c-w>v<c-]>z<cr>

	autocmd FileType c nnoremap <buffer> g<c-g> gg=G<c-o><c-o>

	" compile and execute current
	autocmd FileType c nnoremap <buffer> <leader>gcc :Shell gcc -Wall -Wextra % && ./a.out
	autocmd FileType c nnoremap <buffer> <leader>gcm :Shell gcc -Wall -Wextra % main.c && ./a.out

	" auto close brackets
	autocmd FileType c inoremap <buffer> {<cr>  {<cr>}<esc>O

	" put brackets around paragraph
	autocmd FileType c nnoremap <buffer> <leader>{} {S{<esc>}S}<c-c>=%<c-o><c-o>=iB
augroup end

" put semicolon EOL
nnoremap <leader>; i<c-o>m`<c-o>A;<esc>``<esc>

" go to name of current c function (needs '()')
nnoremap <silent> g<c-d> j[[h^t(b
" select all text in function
nnoremap <leader>vf j[[V%o
" nnoremap viB [[%v%jok$
" nnoremap vaB [[%v%
" " nnoremap vib [{%v%jok$
" nnoremap vab [{%v%

" " Commenting blocks of code.
" autocmd FileType c,cpp,java,scala let b:com_size = '3' | let b:com = '// '
" autocmd FileType sh,ruby,python   let b:com_size = '2' | let b:com = '# '
" autocmd FileType conf,fstab       let b:com_size = '2' | let b:com = '# '
" autocmd FileType tex              let b:com_size = '2' | let b:com = '% '
" autocmd FileType mail             let b:com_size = '2' | let b:com = '> '
" autocmd FileType vim              let b:com_size = '2' | let b:com = '" '
" autocmd FileType readline         let b:com_size = '2' | let b:com = '# '
 
" nnoremap <silent> <leader>'' m'V:norm i<c-r>=expand(b:com)<cr><cr>`'<right><right>
" vnoremap <silent> <leader>'' m':norm i<c-r>=expand(b:com)<cr><cr>`'

" nnoremap <silent> <leader>"" m'V:norm <c-r>=expand(b:com_size)<cr>x<cr>`'<left><left>
" vnoremap <silent> <leader>"" m':norm <c-r>=expand(b:com_size)<cr>x<cr>`'

" noremap <silent> <leader>'p yypk:<c-b> <c-e>s/^\V<c-r>=escape(b:comment_leader,'\/')<cr>//e<cr>:nohlsearch<cr>


""  Auto Header
"""  SH Auto Header

au bufnewfile *.sh 0r $HOME/.vim/skel/bash_header

"""  Auto protect c header
if !exists("autocommands_loaded")
	let autocommands_loaded = 1
	au BufNewFile *.h call InsertCHHeader()
endif

function! InsertCHHeader()
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


""  Latex Mappings

augroup LatexSmith
	autocmd! LatexSmith
	" Navigating with guides
	autocmd FileType plaintex,tex silent inoremap <buffer> ,, <esc>/<++><cr>"_4s
	autocmd FileType plaintex,tex silent vnoremap <buffer> ,, <esc>/<++><cr>"_4s
	autocmd FileType plaintex,tex silent map <buffer> ,, <esc>/<++><cr>"_4s

	autocmd Filetype plaintex,tex silent nnoremap <buffer> \ll :LLPStartPreview

	" Latex snippets
	autocmd FileType plaintex,tex inoremap <buffer> ,fr \begin{frame}<Enter>\frametitle{}<Enter><Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++><esc>6kf}i
	autocmd FileType plaintex,tex inoremap <buffer> ,fi \begin{fitch}<Enter><Enter>\end{fitch}<Enter><Enter><++><esc>3kA
	autocmd FileType plaintex,tex inoremap <buffer> ,exe \begin{exe}<Enter>\ex<space><Enter>\end{exe}<Enter><Enter><++><esc>3kA
	autocmd FileType plaintex,tex inoremap <buffer> ,em \emph{}<++><esc>T{i
	autocmd FileType plaintex,tex inoremap <buffer> ,bf \textbf{}<++><esc>T{i
	autocmd FileType plaintex,tex vnoremap <buffer> , <ESC>`<i\{<ESC>`>2la}<ESC>?\\{<Enter>a
	autocmd FileType plaintex,tex inoremap <buffer> ,it \textit{}<++><esc>T{i
	autocmd FileType plaintex,tex inoremap <buffer> ,ct \textcite{}<++><esc>T{i
	autocmd FileType plaintex,tex inoremap <buffer> ,cp \parencite{}<++><esc>T{i
	autocmd FileType plaintex,tex inoremap <buffer> ,glos {\gll<space><++><space>\\<Enter><++><space>\\<Enter>\trans{``<++>''}}<esc>2k2bcw
	autocmd FileType plaintex,tex inoremap <buffer> ,x \begin{xlist}<Enter>\ex<space><Enter>\end{xlist}<esc>kA<space>
	autocmd FileType plaintex,tex inoremap <buffer> ,ol \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><esc>3kA\item<space>
	autocmd FileType plaintex,tex inoremap <buffer> ,ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><esc>3kA\item<space>
	autocmd FileType plaintex,tex inoremap <buffer> ,li <Enter>\item<space>
	autocmd FileType plaintex,tex inoremap <buffer> ,dc <Enter>\documentclass<space>
	autocmd FileType plaintex,tex inoremap <buffer> ,doc <Enter>\documentation<space>
	autocmd FileType plaintex,tex inoremap <buffer> ,ref \ref{}<space><++><esc>T{i
	autocmd FileType plaintex,tex inoremap <buffer> ,tab \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><esc>4kA{}<esc>i
	autocmd FileType plaintex,tex inoremap <buffer> ,ot \begin{tableau}<Enter>\inp{<++>}<tab>\const{<++>}<tab><++><Enter><++><Enter>\end{tableau}<Enter><Enter><++><esc>5kA{}<esc>i
	autocmd FileType plaintex,tex inoremap <buffer> ,can \cand{}<tab><++><esc>T{i
	autocmd FileType plaintex,tex inoremap <buffer> ,con \const{}<tab><++><esc>T{i
	autocmd FileType plaintex,tex inoremap <buffer> ,v \vio{}<tab><++><esc>T{i
	autocmd FileType plaintex,tex inoremap <buffer> ,a \href{}{<++>}<space><++><esc>2T{i
	autocmd FileType plaintex,tex inoremap <buffer> ,sc \textsc{}<space><++><esc>T{i
	autocmd FileType plaintex,tex inoremap <buffer> ,chap \chapter{}<Enter><Enter><++><esc>2kf}i
	autocmd FileType plaintex,tex inoremap <buffer> ,sec \section{}<Enter><Enter><++><esc>2kf}i
	autocmd FileType plaintex,tex inoremap <buffer> ,ssec \subsection{}<Enter><Enter><++><esc>2kf}i
	autocmd FileType plaintex,tex inoremap <buffer> ,sssec \subsubsection{}<Enter><Enter><++><esc>2kf}i
	autocmd FileType plaintex,tex inoremap <buffer> ,st <esc>F{i*<esc>f}i
	autocmd FileType plaintex,tex inoremap <buffer> ,beg \begin{}<Enter><++><Enter>\end{}<Enter><Enter><++><esc>4k0f{a
	autocmd FileType plaintex,tex inoremap <buffer> ,up <esc>/usepackage<Enter>o\usepackage{}<esc>i
	autocmd FileType plaintex,tex nnoremap <buffer> ,up /usepackage<Enter>o\usepackage{}<esc>i
	autocmd FileType plaintex,tex inoremap <buffer> ,tt \texttt{}<space><++><esc>T{i
	autocmd FileType plaintex,tex inoremap <buffer> ,bt {\blindtext}
	autocmd FileType plaintex,tex inoremap <buffer> ,nu $\varnothing$
	autocmd FileType plaintex,tex inoremap <buffer> ,col \begin{columns}[T]<Enter>\begin{column}{.5\textwidth}<Enter><Enter>\end{column}<Enter>\begin{column}{.5\textwidth}<Enter><++><Enter>\end{column}<Enter>\end{columns}<esc>5kA
	autocmd FileType plaintex,tex inoremap <buffer> ,rn (\ref{})<++><esc>F}i
augroup end


""  Dotfiles settings
""" Filetype
au BufNewFile,BufRead bash_aliases,bashrc,inputrc,.bash_aliases,.bashrc,.inputrc setfiletype sh set nowrap

augroup suffixes
    autocmd!
    let associations = [
                \["javascript", ".js,.javascript,.es,.esx,.json"],
                \["python", ".py,.pyw"],
                \["c", ".c,.h"],
                \["cpp", ".c,.h"]
                \]
    for ft in associations
        execute "autocmd FileType " . ft[0] . " setlocal suffixesadd=" . ft[1]
    endfor
augroup end

""" Vimrc folding
function! VimFold()
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
set modelineexpr

""" Vimrc modeline
" vim:foldmethod=expr:foldtext=VimFold()
" vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-1)\:'='
