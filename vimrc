" **************************************************************************** "
"                                                           LE - /             "
"                                                               /              "
"    vimrc                                            .::    .:/ .      .::    "
"                                                  +:+:+   +:    +:  +:+:+     "
"    By: tris <tristan.kapous@protonmail.com>       +:+   +:    +:    +:+      "
"                                                  #+#   #+    #+    #+#       "
"    Created: 2019/06/23 05:39:33 by tris         #+#   ##    ##    #+#        "
"    Updated: 2019/07/05 10:57:23 by tkapous     ###    #+. /#+    ###.fr      "
"                                                          /                   "
"                                                         /                    "
" **************************************************************************** "

""  Vimrc settings

set nocompatible " not compatible with vi
" set shellcmdflag=-ic
let $BASH_ENV = "$HOME/dotfiles/bash_aliases" " use aliases in vim
let $PAGER=''	" clear pager env var in vim (for vim as pager)
" pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim

" automatically reload vimrc when modified
" autocmd! BufWritePost $MYVIMRC silent source $MYVIMRC

" source vimrc
nnoremap <silent><leader>sv :source $MYVIMRC<CR>:nohlsearch<CR>:echo "vimrc sourced" <CR>:w<CR>
nnoremap <silent><leader>sy :YcmRestartServer<CR>:echo "YCM fresh"<CR>:w<CR>
nnoremap <silent><leader>ss :source $MYVIMRC<CR>:nohlsearch<CR>:YcmRestartServer<CR>:redraw<CR>:w<CR>

" edit dotfiles
nnoremap <leader>ev :vertical split $DOT/vimrc<cr>
nnoremap <leader>eb :vertical split $DOT/bashrc<cr>
nnoremap <leader>ea :vertical split $DOT/bash_aliases<cr>
nnoremap <leader>ei :vertical split $DOT/inputrc<cr>
nnoremap <leader>ep :vertical split $DOT/bash_profile<cr>
nnoremap <leader>ec1 :vertical split $DOT/vim/colors/base16-onedark.vim<cr>
nnoremap <leader>ec2 :vertical split $DOT/vim/colors/base16-one-light.vim<cr>

" automatic views
autocmd BufWritePost,BufLeave,WinLeave ?* mkview
autocmd BufWinEnter ?* silent loadview

set notimeout
set ttimeout
set ttimeoutlen=10


""  General

" let mapleader = " "
" let leader = " "
map <Space> <leader>
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

inoremap jk <ESC>
cmap jk <ESC>
nnoremap gI `.
" inoremap <C-w><C-e> <Esc><silent>:write<CR>
" nnoremap <C-w><C-e> <silent>:write<CR>
nnoremap <C-s> :w<CR>
inoremap <C-s> <C-O>:stopinsert<CR>:w<CR>
cmap W! %!sudo tee > /dev/null %

set history=10000 " default 20

" make backspace behave in a sane manner
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


""  User Interface

set ruler
set mouse=a
set visualbell
set noerrorbells
set t_vb=
set wildmenu
set showmode
set showcmd

" Tabulation control
set noexpandtab				" tabs ftw
set smarttab				" tab respects 'tabstop' 'shiftwidth' 'softtabstop'
set tabstop=4				" the visible width of tabs
set softtabstop=4			" make tabs 4 characters wide
set shiftwidth=4			" make indents 4 characters wide
set autoindent				" automatically set indent of new line
set smartindent				" ... in a sane way
set shiftround				" round indent to a multiple of 'shiftwidth'
filetype indent on

set splitbelow				" default split below
set splitright				" default split right
" set equalalways			" always equalize windows
" set list					" show invisible characters
" set listchars=tab:<Space><Space>,trail:·		" but only show tabs and		trailing whitespace
" set listchars=tab:>\ ,trail:·	" but only show tabs and trailing whitespace
set listchars=tab:\ \ 

set number					" show number column
set relativenumber			" relative to current line

set virtualedit=block		" visual selection broken free

set whichwrap+=<,>,h,l,[,]	" free cursor betweem lines
set wrap					" no horizontal scroll
set linebreak				" break lines
set showbreak=\ ¬			" ... showing a character

set sidescrolloff=3			" horizontal cursor max value
let &scrolloff=winheight(win_getid())/10 " minumum lines before/after cursor

" toggle always in middle with zz
nnoremap zz :let &scrolloff=999-&scrolloff<CR>
" original behavious with <leader>zz
nnoremap <leader>zz zz

" status line
set laststatus=2			" show the satus line all the time
" show buffer number
set statusline=%02n:%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P

" open file under cursor in vertical split
nnoremap <C-w>f :vertical wincmd f<CR>


""  look / theme

syntax on

if (has("termguicolors"))
  set termguicolors
endif
let g:material_theme_style='dark'
let hour = strftime("%H")
if 9 <= hour && hour < 21
	set background=light
	colorscheme base16-one-light
else
	set background=dark
	colorscheme base16-onedark
" 	let g:lightline = { 'colorscheme': 'material_vim' }
endif
set background=dark
colorscheme base16-onedark

" source colors
nnoremap <leader>s1 :source $HOME/.vim/colors/base16-onedark.vim<CR>
nnoremap <leader>s2 :source $HOME/.vim/colors/base16-one-light.vim<CR>
" nnoremap <leader>s1 :source $HOME/.vim/colors/trikai.vim<CR>
" nnoremap <leader>s2 :source $HOME/.vim/colors/trikai_light.vim<CR>

" code
set encoding=utf8
let base16colorspace=256  " access colors present in 256 colorspace"
set t_Co=256 " explicitly tell vim that the terminal supports 256 colors"


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
set cursorline		" color current line
set colorcolumn=81	" color column 81
" autocmd InsertEnter * highlight CursorLine guibg=#000050 guifg=fg
" autocmd InsertLeave * highlight CursorLine guibg=#004000 guifg=fg

" set textwidth=81
" set textwidth=0
" let &colorcolumn=join(range(82,999),",")
" if exists('+colorcolumn')
" 	set colorcolumn=80
" else
" 	au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
" endif

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
au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown

" refresh filetype upon writing
autocmd BufWritePost * filetype detect

" load the first 'tags' file in dir tree
" set tags=tags;/$HOME

" let is_git=:exec 'cd' fnameescape(fnamemodify(finddir('.git',
"     \ escape(expand('%:p:h'), ' ') . ';'), ':h'))

" autocmd BufEnter * silent! :exec 'cd' fnameescape(fnamemodify(finddir('.git',
"     \ escape(expand('%:p:h'), ' ') . ';'), ':h'))

" if in git repo, sets tags
" let &tags = fnameescape(get(systemlist('git rev-parse --show-toplevel'), 0)) . '/.git/tags';
" if tags (so if in git repo), autochdir to git root
" 			\ if exists('&tags') |
" 			\ echo &tags |
" autocmd BufWinEnter,BufEnter,WinEnter,TabEnter *
" 			\ let b:gitroot = fnameescape(get(systemlist('git rev-parse --show-toplevel'), 0))
" 			\ if (b:gitroot =~ 'fatal*') |
" 			\	silent! :exec 'lcd %:p:h' |
" 			\ else |
" 			\	silent! :exec 'lcd b:gitroot' |
" " 			\	silent! :exec 'cd' fnameescape(fnamemodify(finddir('.git',
" " 			\	escape(expand('%:p:h'), ' ') . ';'), ':h')) |
" 			\ endif
" 
" autoreload tags file on save
au BufWritePost *.c,*.cpp,*.h silent! !ctags -R --langmap=c:.c.h &
au BufWritePost *.cpp silent! !ctags -R &


""  Folding

set foldmethod=syntax " fold based on indent
set foldnestmax=10 " deepest fold is 10 levels
set nofoldenable " don't fold by default
set foldlevel=1
" automatily save and restore views (folding state of files)
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

" inoremap <leader><space> <C-O>za
nnoremap <leader><space> za
onoremap <leader><space> <C-C>za
vnoremap <leader><space> zf

" Make zo recursively open whatever fold we're in, even if it's partially open.
nnoremap zo zczO

""  Netrw

" Toggle Vexplore with <leader>t
" function! ToggleVExplorer()
"     if exists("t:expl_buf_num")
"         let expl_win_num = bufwinnr(t:expl_buf_num)
"         let cur_win_num = winnr()
"         if expl_win_num != -1
"             while expl_win_num != cur_win_num
"                 exec "wincmd w"
"                 let cur_win_num = winnr()
"             endwhile
"             close
"         endif
"         unlet t:expl_buf_num
"     else
"          Vexplore
"          let t:expl_buf_num = bufnr("%")
"     endif
" endfunction
" nnoremap <silent> <leader>t :call ToggleVExplorer()<CR>

let g:NetrwIsOpen=0
function! ToggleNetrw()
	if g:NetrwIsOpen
		let i = bufnr("$")
		while (i >= 1)
			if (getbufvar(i, "&filetype") == "netrw")
				silent exe "bwipeout " . i
			endif
			let i-=1
		endwhile
		let g:NetrwIsOpen=0
	else
		let g:NetrwIsOpen=1
		silent Lexplore
	endif
endfunction
nnoremap <silent> <leader>t :call ToggleNetrw()<CR>

" Netrw customization
let g:netrw_keepdir= 0
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 2
let g:netrw_altv = 1
let g:netrw_winsize = -25
let g:netrw_sort_sequence = '[\/]$,*'				" sort folders on top
" autocmd filetype netrw nmap <c-a> <cr>:wincmd W<cr>	" open file keep netrw focus

" open netrw with vim
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END
" autocmd filetype netrw nnoremap <c-a> <cr>:wincmd W<cr>


""  Quickfix

augroup ft_quickfix
	au!
	au Filetype qf setlocal colorcolumn=0 nolist nocursorline tw=0

	" vimscript is a joke
	au Filetype qf nnoremap <buffer> <cr> :execute "normal! \<lt>cr>"<cr>
augroup END


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

nnoremap <leader>cm :make re<CR><CR>
nnoremap <leader>cc :cc<CR>
nnoremap <leader>cn :cn<CR>
nnoremap <leader>cp :cp<CR>
nnoremap <leader>cl :clist<CR>
nnoremap <leader>cw :cwindow<CR>
nnoremap <leader>ln :lnext<CR>
nnoremap <leader>lp :lprevious<CR>
nnoremap <leader>ll :ll<CR>

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
" nnoremap zM zMzz
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
nnoremap <silent>- :nohlsearch<CR>
" For local sed replace
nnoremap gr :s/<C-R>///g<left><left>
vnoremap gr :s/<C-R>///g<left><left>
" For global sed replace
nnoremap gR :%s/<C-R>///g<left><left>
vnoremap gR :%s/<C-R>///g<left><left>

" search visual selection
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
" xnoremap <leader>p "_dP

""  Code mappings

inoremap main<tab> <Esc>:Header101<CR>iint<tab><tab>main(int ac, char **av)<CR>{<CR>}<Esc>Oreturn(0);<Esc>O
nnoremap main<tab> :Header101<CR>iint<tab><tab>main(int ac, char **av)<CR>{<CR>}<Esc>Oreturn(0);<Esc>O
inoremap if<tab> if ()<CR>{<CR>}<Esc>2k3==f)i
inoremap while<tab> while ()<CR>{<CR>}<Esc>2k3==f)i

nnoremap <C-G> %
" compile and execute current
nnoremap <leader>gcc :!gccf % && ./a.out

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
nnoremap <silent> <leader>gf j[[h^t(b
nnoremap <silent> <leader>gF j[[h^t(b
" go to next call of function you are in
nnoremap <silent> <leader>gn j[[h^t(b*
" select all text in function
nnoremap <leader>vf [[%v%
nnoremap <leader>gd [[kf(B
" nnoremap viB [[%v%jok$
" nnoremap vaB [[%v%
" " nnoremap vib [{%v%jok$
" nnoremap vab [{%v%

" Commenting blocks of code.
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
autocmd FileType readline         let b:comment_leader = '# '
noremap <silent> <leader>'' :<C-B> <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> <leader>"" :<C-B> <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>
noremap <silent> <leader>'p yypk:<C-B> <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" Open man page in vim split, defaults to K
runtime! ftplugin/man.vim
set keywordprg=:Man

""  Mappings

" <c-z> will work in insert mode
inoremap <C-Z> <C-[><C-Z>

" moving up and down work as you would expect
nnoremap <silent> j gj
nnoremap <silent> k gk

" set clipboard=unnamed
" let g:clipbrdDefaultReg = '+'

" paste with indentation
" nnoremap P mp]P==`p
" nnoremap p mp]p==`p

nnoremap cl c$
nnoremap dl d$
nnoremap yl y$
nnoremap ch c^
nnoremap dh d^
nnoremap yh y^

" vnoremap cl c$
" vnoremap dl d$
" vnoremap yl y$
" vnoremap ch c^
" vnoremap dh d^
" vnoremap yh y^

" Copy/paste text to/from the system clipboard.
nnoremap <leader>p mp"*]p==`p
nnoremap <leader>P mp"*]P==`p
nnoremap <leader>y "*y
nnoremap <leader>Y "*y$

" vnoremap <leader>p mp"*]p==`p
" vnoremap <leader>P mp"*]P==`p
vnoremap <leader>y "*y
" vnoremap <leader>Y "*yy

nnoremap H ^
nnoremap L g_
nnoremap <C-h> B
nnoremap <C-l> W
nnoremap <C-k> {
nnoremap <C-j> }
nnoremap <C-q> <silent>:redraw<CR>

vnoremap H ^
vnoremap L g_
vnoremap <C-h> B
vnoremap <C-l> W
vnoremap <C-k> {
vnoremap <C-j> }

cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-l> <S-Right>
cnoremap <C-h> <S-Left>
cnoremap <C-x> <Del>

" helpers for dealing with other people's code
" nmap \t :set ts=4 sts=4 sw=4 noet<cr>
" nmap \s :set ts=4 sts=4 sw=4 et<cr>


""  Auto Header
"""  SH Auto Header
au bufnewfile *.sh 0r $HOME/.vim/skel/bash_header

"""  Auto protect .h
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


""  Autocompletion

set completeopt=longest,menuone
" set completeopt=menuone


" inoremap <c-x>f <c-x><c-f>
" inoremap <c-x>] <c-x><c-]>
" inoremap <c-x>l <c-x><c-l>

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

" Open buffer in split on partial search
function! BufSel(pattern)
  let bufcount = bufnr("$")
  let currbufnr = 1
  let nummatches = 0
  let firstmatchingbufnr = 0
  while currbufnr <= bufcount
    if(bufexists(currbufnr))
      let currbufname = bufname(currbufnr)
      if(match(currbufname, a:pattern) > -1)
        echo currbufnr . ": ". bufname(currbufnr)
        let nummatches += 1
        let firstmatchingbufnr = currbufnr
      endif
    endif
    let currbufnr = currbufnr + 1
  endwhile
  if(nummatches == 1)
    execute ":buffer ". firstmatchingbufnr
  elseif(nummatches > 1)
    let desiredbufnr = input("Enter buffer number: ")
    if(strlen(desiredbufnr) != 0)
      execute ":buffer ". desiredbufnr
    endif
  else
    echo "No matching buffers"
  endif
endfunction

"Bind the BufSel() function to a user-command
command! -nargs=1 Bs :call BufSel("<args>")


" open buffer in split on partial search
nnoremap <leader>b :vertical sbuffer<space>
" nnoremap <leader>T :vertical sbuffer !/bin/bash<CR>

"go to next / previous buffer
nnoremap <leader>] :bn<CR>
nnoremap <leader>[ :bp<CR>

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
tnoremap <leader>T <C-\><C-n>:call Term_toggle(10)<cr>

" move between windows with ctrl
" nnoremap <C-h> :wincmd h<CR>
" nnoremap <C-j> :wincmd j<CR>
" nnoremap <C-k> :wincmd k<CR>
" nnoremap <C-l> :wincmd l<CR>
" imap <C-w> <C-o><C-w>

" Note: does not work anymore?
" resize windows quicker
" nnoremap <silent><C-w><C-.> :vertical resize +10<CR>
" nnoremap <silent><C-w><C-,> :vertical resize -10<CR>
" nnoremap <silent><C-w><C-=> :resize +10<CR>
" nnoremap <silent><C-w><C--> :resize -10<CR>

" new file in vertical split instead of horizontal
nnoremap <C-w><C-n> :vertical new<CR>
nnoremap <C-w>n :vertical new<CR>
nnoremap <C-w><C-f> :vertical wincmd f<CR>


""  Plugins settings

execute pathogen#infect()

" fugitive
nnoremap <leader>gg :vertical Gstatus<CR>
set diffopt+=vertical " vertical split for diff

" YouCompleteMe
" autocmd insertenter * silent! :YcmRestartServer "keep Ycm from fuckin up
let g:ycm_show_diagnostics_ui = 1 " keep syntastic errors
let g:ycm_key_list_stop_completion = [ '<C-y>', '<Enter>' ] " validate with Enter
let g:ycm_key_list_select_completion = ['<C-j>', '<Down>']	" next
let g:ycm_key_list_previous_completion = ['<C-k>', '<Up>']	" previous
let g:ycm_collect_identifiers_from_tags_files = 1			"use tags
let g:ycm_disable_for_files_larger_than_kb = 12000	" for fugitive status window

" inoremap <expr> <TAB> pumvisible() ? "\<C-v>\<TAB>" : "\<TAB>"
" inoremap <expr> <c-j> pumvisible() ? "\<C-n>" : "\<TAB>"
" inoremap <expr> <c-k> pumvisible() ? "\<C-p>" : "\<S-TAB>"
" syntastic
" let g:syntastic_c_config_file = ['$HOME/dotfiles/.vim/c_errors_file']
let g:syntastic_c_include_dirs = ['inc']

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" set statusline+=%H*

" let g:syntastic_c_remove_include_errors = 1
let g:syntastic_enable_c_checker = 1
let g:syntastic_c_checkers = ['make', 'gcc', 'clangcheck']
let g:ycm_use_clangd = 1

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


" lightline
set noshowmode " do not show mode in status line
" Show full path of filename

function! FilenameForLightline()
    return expand('%')
endfunction

" show git branch
let g:lightline = {
			\ 'colorscheme': 'wombat',
			\ 'active': {
			\   'left': [ [ 'mode', 'paste' ],
			\             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
			\ },
			\ 'component_function': {
			\   'gitbranch': 'fugitive#head', 'filename': 'FilenameForLightline'
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

" man
let g:ft_man_open_mode = 'vert'

set updatetime=20 " refresh more frequently from
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk

" FZF
" let g:fzf_layout = { 'window': 'below 10split enew' }
" call fzf#run({'options': '--reverse'})
nnoremap <leader>F :FZF /<CR>			"search files from root
nnoremap <leader>f :FZF $HOME<CR>		"search files from HOME
nnoremap <leader><C-F> :FZF .<CR>		"search files from curr
" nnoremap <leader>f :FZF<C-r>=fnamemodify(getcwd(), ':p')<CR><CR>
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

" Root
let g:root#auto = 1
let g:root#echo = 0

" Searchhi
let g:searchhi_clear_all_autocmds = 'InsertEnter'
let g:searchhi_update_all_autocmds = 'InsertLeave'
let g:searchhi_open_folds = 0

""  101
""" 101Header


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
" nnoremap <leader>h1 :Header101<CR>
nnoremap <silent> <leader>h1 :call Stdheader()<CR>
" autocmd BufWritePre * call s:update ()


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

""  Dotfiles
""" Filetype
au BufNewFile,BufRead bash_aliases,bashrc,inputrc,.bash_aliases,.bashrc,.inputrc setfiletype sh

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
augroup END

""" Vimrc folding
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
