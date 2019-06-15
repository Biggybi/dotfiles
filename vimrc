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

" pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim

" automatically reload vimrc when modified
" autocmd! BufWritePost $MYVIMRC silent source $MYVIMRC

" source vimrc
nnoremap <silent><leader>sv :source $MYVIMRC<CR>:nohlsearch<CR>:echo "vimrc sourced"<CR>
nnoremap <silent><leader><leader>y :YcmRestartServer<CR>

" edit vimrc
nnoremap <leader>ev :vertical split $HOME/dotfiles/vimrc<cr>

autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview


""  General

let mapleader=','
let leader=','

inoremap jk <ESC>
set background=dark
" inoremap <C-w><C-e> <Esc><silent>:write<CR>
" nnoremap <C-w><C-e> <silent>:write<CR>
nnoremap <C-s> :w<CR>
inoremap <C-s> <C-O>:stopinsert<CR>:w<CR>
cmap W! %!sudo tee > /dev/null %

set history=1000 " default 20

set nocompatible " not compatible with vi

" make backspace behave in a sane manner
set backspace=indent,eol,start

" faster redrawing
set ttyfast

" Backup files dir
set backupskip=/tmp/*,/private/tmp/*"		" vim can edit crontab
set backupdir=$HOME/.vim/backup//
set directory=$HOME/.vim/swap//
set undodir=$HOME/.vim/undo//

" No error message when swap exists, just edit
set shortmess+=A

" set noswapfile


""  User Interface

set ruler
set mouse=a
set visualbell
set wildmenu
set showmode
set showcmd
set showbreak=¬

" show buffer number
set statusline=%02n:%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set laststatus=2			" show the satus line all the time

set number
set relativenumber

set equalalways				" always equalize windows

set whichwrap+=<,>,h,l,[,]	" free cursor betweem lines

set scrolloff=3			" minumum lines before/after cursor

" Tabulation control
set noexpandtab				" tabs ftw
set smarttab				" tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=4				" the visible width of tabs
set softtabstop=4			" make tabs 4 characters wide
set shiftwidth=4			" make indents 4 characters wide
set autoindent				" automatically set indent of new line
set smartindent
set shiftround				" round indent to a multiple of 'shiftwidth'
filetype indent on

set splitbelow				" default split below
set splitright				" default split right


""  look / theme

" syntax on

" night theme
let hour = strftime("%H")
if 9 <= hour && hour < 19
	colorscheme trikai_light
else
	colorscheme trikai
endif

" source colors
nnoremap <leader>sc1 :source $HOME/.vim/colors/trikai.vim<CR>
nnoremap <leader>sc2 :source $HOME/.vim/colors/trikai_light.vim<CR>

" code
set encoding=utf8
let base16colorspace=256  " access colors present in 256 colorspace"
set t_co=256 " explicitly tell vim that the terminal supports 256 colors"
"


""  highlights / match

" highlight overlength ctermbg=203 ctermfg=white guibg=#592928
" match overlength /\%81v.\+/

" show traling whitespaces
"highlight whitespacetrim ctermbg=203 ctermfg=white guibg=#592928
highlight trailingwhitespace ctermbg=203 guibg=red
match trailingwhitespace /\s\+$/
autocmd bufwinenter * match trailingwhitespace /\s\+$/
autocmd insertenter * match trailingwhitespace /\s\+\%#\@<!$/
autocmd insertleave * match trailingwhitespace /\s\+$/
autocmd bufwinleave * call clearmatches()

"highlight colorcolumn ctermbg=9
set colorcolumn=81
" set textwidth=81
" let &colorcolumn=join(range(82,999),",")
"if exists('+colorcolumn')
"  set colorcolumn=80
"else
"  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
"endif
"
set mat=2 " how many tenths of a second to blink


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
au FileType c setl ofu=ccomplete#CompleteCpp
au FileType css setl ofu=csscomplete#CompleteCSS
au FileType html,xhtml setl ofu=htmlcomplete#CompleteTags
au FileType php setl ofu=phpcomplete#CompletePHP
au FileType ruby,eruby setl ofu=rubycomplete#Complete

" refresh filetype upon writing
autocmd BufWritePost * filetype detect

au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown


""  Code folding

set foldmethod=syntax " fold based on indent
set foldnestmax=10 " deepest fold is 10 levels
set nofoldenable " don't fold by default
set foldlevel=1
" automatily save and restore views (folding state of files)
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf

" keep cursor in middle of screen when searching / folding
nnoremap <leader>z zMzvzz
nnoremap zM zMzz
nnoremap za zazz
nnoremap zA zAzz

""  Netrw

" Toggle Vexplore with <leader>t
function! ToggleVExplorer()
if exists("t:expl_buf_num")
	let expl_win_num = bufwinnr(t:expl_buf_num)
	if expl_win_num != -1
		let cur_win_nr = winnr()
		exec expl_win_num . 'wincmd w'
		close
		exec cur_win_nr . 'wincmd w'
		unlet t:expl_buf_num
	else
		unlet t:expl_buf_num
	endif
else
	exec '1wincmd w'
	Vexplore
	setlocal winfixwidth
	let t:expl_buf_num = bufnr("%")
endif
endfunction
nnoremap <silent> <leader>t :call ToggleVExplorer()<CR>

" Netrw customization
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 2
let g:netrw_altv = 1
let g:netrw_winsize = -25
let g:netrw_sort_sequence = '[\/]$,*' " sort folders on top
" open netrw with vim
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END
" autocmd filetype netrw nnoremap <c-a> <cr>:wincmd W<cr>


""  Quickfix

" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
"
" Note: Must allow nesting of autocmds to enable any customizations for quickfix
" buffers.
" Note: Normally, :cwindow jumps to the quickfix window if the command opens it
" (but not if it's already open). However, as part of the autocmd, this doesn't
" seem to happen.

nnoremap <Leader>cm :make re<CR><CR><CR>
nnoremap <Leader>cc :cc<CR>
nnoremap <Leader>cn :cn<CR>
nnoremap <Leader>cp :cp<CR>
nnoremap <Leader>cl :clist<CR>
nnoremap <Leader>cw :cwindow<CR>
autocmd QuickFixCmdPost [^l]* nested botright copen
autocmd QuickFixCmdPost    l* nested botright lwindo


""  Shell output in new split

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
setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
call setline(1, a:cmdline . '    |    ' . expanded_cmdline)
call setline(2,substitute(getline(1),'.','=','g'))
execute '$read !'. expanded_cmdline
setlocal nomodifiable
endfunction


""  Searching

set path+=**			" recursive path from current path
" set incsearch
set wildchar=<Tab>
set wildmode=full
" set wildmode=longest:full:list,full


set ignorecase			" case insensitive searching
set smartcase			" case-sensitive if expresson contains a capital letter
set hlsearch			" highlight all searches
set incsearch			" set incremental search, like modern browsers
set nolazyredraw		" don't redraw while executing macros

set switchbuf=useopen	" open buffers in their window if exist (:sb nam)

" ignore some files from fuzzy search
set wildignore+=**/.git/**,**/__pycache__/**,**/venv/**,**/node_modules/**,**/dist/**,**/build/**,*.o,*.pyc,*.swp

set magic " Set magic on, for regex

" keep cursor in middle of screen when searching / folding
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#

" uset unix regex in searche
" nnoremap / /\v
" vnoremap / /\v

"do not move cursor with match
nnoremap <silent> * :let @/= '\<' . expand('<cword>') . '\>' <bar> set hls <cr>
nnoremap <silent> g* :let @/=expand('<cword>') <bar> set hls <cr>

"Clear search highlight pressing Enter
nnoremap <silent><BS> :nohlsearch<CR><CR>
" For local sed replace
nnoremap gr gd:s/<C-R>///gc<left><left><left>
" For global sed replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>

function! s:VSetSearch()
let temp = @@
norm! gvy
let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
let @@ = temp
endfunction

vnoremap * :<C-u>cal <SID>VSetSearch()<CR>//<CR><c-o>
vnoremap # :<C-u>cal <SID>VSetSearch()<CR>??<CR><c-o>

""  Edit mappings

" delete without saving to register
nnoremap <leader>d "_d
xnoremap <leader>d "_d
xnoremap <leader>p "_dP


""  Code mappings

" auto close bracers
" inoremap (      ();<Left><Left>
" inoremap (;  (<CR>)<Esc>O
" inoremap ((     (
" inoremap ()     ()

" auto close brackets
inoremap {<CR>  {<CR>}<Esc>O
" inoremap {      {}<Left>
" inoremap {{     {
" inoremap {}     {}

" put brackets around paragraph
nnoremap <leader>{} {S{<Esc>}S}<c-c>=%

" put semicolon EOL
" inoremap <leader>; <C-o>m`<C-o>A;<Esc>``i
nnoremap <leader>; i<C-o>m`<C-o>A;<Esc>``<Esc>

" go to name of function you are in (needs a '()')
nnoremap <silent> gid j[[h^t(b
" go to next call of function you are in
nnoremap <silent> gin j[[h^t(b*
" select all text in function
nnoremap vif [{%v%

" Commenting blocks of code.
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
noremap <silent> <leader>'' :<C-B> <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> <leader>"" :<C-B> <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>


""  Mappings

" <c-z> will work in insert mode
inoremap <C-Z> <C-[><C-Z>

" moving up and down work as you would expect
nnoremap <silent> j gj
nnoremap <silent> k gk

" Copying/pasting text to the system clipboard.
" set clipboard=unnamed
noremap  <leader>p "+p
nnoremap <leader>y VV"+y
nnoremap <leader>Y "+y
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>d "+d
vnoremap <leader>y "+y
vnoremap <Leader>p "+p
vnoremap <Leader>P "+P

nnoremap H ^
nnoremap L g_
nnoremap <C-h> B
nnoremap <C-l> E
nnoremap <C-k> {
nnoremap <C-j> }
nnoremap <C-q> <silent>:redraw<CR>

cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-l> <S-Right>
cnoremap <C-x> <Del>

" helpers for dealing with other people's code
" nmap \t :set ts=4 sts=4 sw=4 noet<cr>
" nmap \s :set ts=4 sts=4 sw=4 et<cr>


""  Autocompletion

set completeopt=longest,menuone
" set completeopt=menuone

inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

inoremap <c-x>f <c-x><c-f>
inoremap <c-x>] <c-x><c-]>
inoremap <c-x>l <c-x><c-l>

" auto show autocomplete omnibox
" inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
"   \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
" inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
"   \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
"
" " " enter selects menu element
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" " " better menu behavior (keeps element hihlighted, <CR> (enter) to select always)
" inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
"   \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
" inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
"   \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
" " " open omni completion menu closing previous if open and opening new menu without changing the text
" inoremap <expr> <C-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
"              \ '<C-x><C-o><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'
"

""  Window behaviour

" jump or open matching buffer in new vertical split
nnoremap <leader>j :vertical sbuffer<space>

" move between windows with ctrl
" nnoremap <C-h> :wincmd h<CR>
" nnoremap <C-j> :wincmd j<CR>
" nnoremap <C-k> :wincmd k<CR>
" nnoremap <C-l> :wincmd l<CR>
" imap <C-w> <C-o><C-w>

" resize windows quicker
nnoremap <silent><C-w><C-.> :vertical resize +10<CR>
nnoremap <silent><C-w><C-,> :vertical resize -10<CR>
nnoremap <silent><C-w><C-=> :resize +10<CR>
nnoremap <silent><C-w><C--> :resize -10<CR>

" new file in vertical split instead of horizontal
nnoremap <C-w><C-n> :vertical new<CR>
nnoremap <C-w>n :vertical new<CR>

""  Plugins

execute pathogen#infect()

" fugitive
set diffopt+=vertical " vertical split for diff

" YouCompleteMe
let g:ycm_show_diagnostics_ui = 0 " compatibility with syntastic for C langs

" syntastic
" let g:syntastic_c_config_file = ['$HOME/dotfiles/.vim/c_errors_file']

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" let g:syntastic_c_remove_include_errors = 1
let g:syntastic_enable_c_checker = 1
let g:syntastic_c_checkers = ['make', 'gcc', 'clangcheck']
let g:ycm_use_clangd = 0

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" lightline
set noshowmode " do not show mode in status line

" show git branch
let g:lightline = {
			\ 'colorscheme': 'wombat',
			\ 'active': {
			\   'left': [ [ 'mode', 'paste' ],
			\             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
			\ },
			\ 'component_function': {
			\   'gitbranch': 'fugitive#head'
			\ },
			\ 'inactive': {
			\   'left': [ [ 'mode', 'paste' ],
			\             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
			\ },
			\ }

" gitgutter
if exists('&signcolumn')  " Vim 7.4.2201
	set signcolumn=yes
else
	let g:gitgutter_sign_column_always = 1
endif

set updatetime=20 " refresh more frequently
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk

" FZF
" let g:fzf_layout = { 'window': 'below 10split enew' }
" call fzf#run({'options': '--reverse'})
nnoremap <leader>f :FZF<CR>
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

""  Vim folding
function! VimFold()
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
	if windowwidth > 80
		let windowwidth = 79
	endif
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 - len(foldedlinecount))
 	if len(line) > windowwidth - 15
		let line=line[0:windowwidth - 15]
	endif
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . repeat(" ", fillcharcount%2 + len(foldedlinecount)) . '' . repeat(" .",fillcharcount/2 - 3) . repeat(" ", 5 - len(foldedlinecount)) . foldedlinecount . '    '
endfunction

" vim:foldmethod=expr:foldtext=VimFold()
" vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-1)\:'='
